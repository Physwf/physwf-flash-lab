package com.physwf.engine.fight.manager
{
	import com.physwf.components.command.Command;
	import com.physwf.components.command.CommandSequence;
	import com.physwf.components.command.ICommand;
	import com.physwf.components.command.LinerCmdSequence;
	import com.physwf.components.effects.TargetEffect;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.command.CmdGoToForAttack;
	import com.physwf.engine.common.command.CmdOnHurt;
	import com.physwf.engine.common.command.CmdSingleAtk;
	import com.physwf.engine.common.command.CmdStand;
	import com.physwf.engine.common.events.CharacterEvent;
	import com.physwf.engine.fight.Fight;
	import com.physwf.engine.fight.controller.ChallengeController;
	import com.physwf.engine.world.objects.Character;
	import com.physwf.engine.world.objects.Monster;
	import com.physwf.engine.world.objects.Player;
	import com.physwf.system.System;
	import com.physwf.system.events.DeathEvent;
	import com.physwf.system.events.FightEvent;
	import com.physwf.system.vo.FightInfo;
	import com.physwf.system.vo.FightObject;
	import com.physwf.system.vo.MonsterInfo;
	import com.physwf.system.vo.SkillInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	public class Challenge extends EventDispatcher implements IUpdatable
	{
		public var target:Character;//选中的目标
		public var basicSkill:SkillInfo;//基础技能
		public var selectSill:SkillInfo;//点击技能栏选择的技能
		
		public static var targetEffect:TargetEffect;
		
		private var targetID:uint = 0;
		private var controller:ChallengeController;
		private var lastAtk:uint = 0;
		private var isIdle:Boolean = true;
		
		public function Challenge()
		{
			Engine.challenge = this;
		}
		
		public function initialize():void
		{
			controller = new ChallengeController();
			controller.initialize(this);
		}
		
		public function onWorldDestroy():void
		{
			System.fight.removeEventListener(FightEvent.FIGHT_RESULT,onFightEvent);
			System.fight.removeEventListener(FightEvent.FIGHT_DEATH,onFightEvent);
			System.fight.removeEventListener(DeathEvent.SELF_DEATH,onDeathEvent);//temp
		}
		
		public function onWorldReady():void
		{
			System.fight.addEventListener(FightEvent.FIGHT_RESULT,onFightEvent);
			System.fight.addEventListener(FightEvent.FIGHT_DEATH,onFightEvent);
			System.fight.addEventListener(DeathEvent.SELF_DEATH,onDeathEvent);//temp
		}
		
		private function onFightEvent(e:FightEvent):void
		{
			switch(e.type)
			{
				case FightEvent.FIGHT_RESULT:
					var fInfo:FightInfo = e.info;
					var cInfo:Object = {};
					var chara:Character = getCharacterByID(fInfo.srcType,fInfo.srcId,cInfo);
					if(chara != Player.self)
					{
						var attack:CmdSingleAtk = new CmdSingleAtk(chara);
						var skill:SkillInfo = basicSkill;//temp
						attack.skill = skill;
						attack.setTarget(target);
						var seq:LinerCmdSequence = new LinerCmdSequence();
						seq.addCommand(attack);
						seq.addCommand(new CmdStand(chara));
						chara.execute(seq);
					}
					var objs:Vector.<FightObject> = fInfo.objects;
					for(var i:uint =0 ;i<objs.length;++i)
					{
						var target:Character = getCharacterByID(objs[i].type,objs[i].id,cInfo)
						var hpHurt:uint = cInfo.info.hp - objs[i].hp;
						cInfo.info.hp = objs[i].hp;
						trace("战斗结果->","源:"+fInfo.srcId,"对象:"+objs[i].id,"伤害:"+objs[i].hp,"技能:"+fInfo.skillID,"hp:"+cInfo.info.hp);
						if(target)
						{
							var targetSeq:LinerCmdSequence = new LinerCmdSequence();
							var onHurt:CmdOnHurt = new CmdOnHurt(target);
							onHurt.setHurt(hpHurt,skill);
							targetSeq.addCommand(onHurt);
							target.createThread(targetSeq);
							targetSeq.execute();
						}
					}
					break;
				case FightEvent.FIGHT_DEATH:
					cInfo = {};
					fInfo = e.info;
					objs = fInfo.objects;
					for(i =0 ;i<objs.length;++i)
					{
						chara = getCharacterByID(objs[i].type,objs[i].id,cInfo);
						if(chara is Player)
						{
							dispatchEvent(new CharacterEvent(CharacterEvent.PLAYER_DIE,chara));
						}
						else if(chara is Monster)
						{
							dispatchEvent(new CharacterEvent(CharacterEvent.MONSTER_DIE,chara));
							var mInfo:MonsterInfo = System.npc.getMonsInfoById(chara.id,true);
							Engine.map.delMonster(mInfo);
						}
						chara.die();
					}
					break;
			}
		}
		
		private function onDeathEvent(e:DeathEvent):void
		{
			switch(e.type)
			{
				case DeathEvent.SELF_DEATH:
					//temp
					break;
			}
		}
		
		private function getCharacterByID(type:uint,id:uint,info_out:Object):Character
		{
			if(type == Fight.FIGHT_CHARA_TYPE_PLAYER)
			{
				var player:Player = Engine.map.getPlayerByUID(id);
				info_out.info = player.info;
				return player;
			}
			else if(type == Fight.FIGHT_CHARA_TYPE_PET)
			{
				return null;
			}
			else if(type == Fight.FIGHT_CHARA_TYPE_NPC)
			{
				var monster:Monster = Engine.map.getMonsterByMID(id);
//				trace(monster.info.hp,"monster.info.hp");
				info_out.info = monster.info;
				//ConfigReader.readMonster(info_out.info.id,info_out.info);//temp
				return monster;
			}
			return null;
		}
		
		public function setTarget(tgt:Character,id:uint):void
		{
			target = tgt;
			targetID = id;
		}
		
		private function getCmd(tgt:Character,id:uint):ICommand
		{
			var distX:Number = target.view.x - Player.self.view.x;
			var distY:Number = target.view.y - Player.self.view.y;
			var rad:Number = Math.atan2(distY,distX);
			var skills:Vector.<SkillInfo> = System.skill.skills;
			var random:uint = Math.random() * skills.length;
			var skill:SkillInfo = skills[random];
			trace(skill,skill.id,"skill");
			var attack:CmdSingleAtk = new CmdSingleAtk(Player.self);
			attack.setTarget(tgt);
			attack.skill = skill;
			
			attack.addEventListener(Command.FINISH,onAttack);
			
			var seq:LinerCmdSequence = new LinerCmdSequence();
			var secureRange:uint = skill.range - 15;//保险范围，
			if((distX * distX + distY * distY) > (skill.range * skill.range))
			{
				var walkCmd:CmdGoToForAttack = new CmdGoToForAttack(Player.self);
				walkCmd.setDest(tgt.view.x,tgt.view.y);
				walkCmd.setSkill(skill);
				seq.addCommand(walkCmd);
			}
			seq.addCommand(attack);
			seq.addCommand(new CmdStand(Player.self));
			seq.addEventListener(Command.FINISH,onSeqFinish);
			return seq;
		}
		
		private function onAttack(e:Event):void
		{
			var cmd:Command = e.target as Command;
			cmd.removeEventListener(Command.FINISH,onAttack);
			lastAtk = getTimer();
		}
		
		private function onSeqFinish(e:Event):void
		{
			var seq:CommandSequence = e.target as CommandSequence;
			seq.removeEventListener(Command.FINISH,onSeqFinish);
			isIdle = true;
		}
		
		public function update():void
		{
			if(target && isIdle)
			{
				if(getTimer() - lastAtk > 6000)
				{
					var cmd:ICommand = getCmd(target,targetID);
					Player.self.execute(cmd);
					isIdle = false;
				}
			}
		}
	}
}
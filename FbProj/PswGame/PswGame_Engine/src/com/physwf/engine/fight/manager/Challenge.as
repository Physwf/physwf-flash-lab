package com.physwf.engine.fight.manager
{
	import com.physwf.components.command.CommandSequence;
	import com.physwf.components.command.LinerCmdSequence;
	import com.physwf.components.effects.TargetEffect;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.command.CmdGoToForAttack;
	import com.physwf.engine.common.command.CmdOnHurt;
	import com.physwf.engine.common.command.CmdSingleAtk;
	import com.physwf.engine.common.command.CmdStand;
	import com.physwf.engine.common.events.MonsterEvent;
	import com.physwf.engine.common.events.PlayerEvent;
	import com.physwf.engine.fight.Fight;
	import com.physwf.engine.fight.controller.ChallengeController;
	import com.physwf.engine.world.objects.Character;
	import com.physwf.engine.world.objects.Monster;
	import com.physwf.engine.world.objects.Player;
	import com.physwf.system.System;
	import com.physwf.system.events.DeathEvent;
	import com.physwf.system.events.FightEvent;
	import com.physwf.system.vo.FightInfo;
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.EventDispatcher;
	
	public class Challenge extends EventDispatcher implements IUpdatable
	{
		public var target:Character;//选中的目标
		public var basicSkill:SkillInfo;//基础技能
		public var selectSill:SkillInfo;//点击技能栏选择的技能
		
		public static var targetEffect:TargetEffect;
		
		private var targetID:uint = 0;
		private var controller:ChallengeController;
		private var lastAtk:uint = 0;
		
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
					var target:Character = getCharacterByID(fInfo.objType,fInfo.objId,cInfo)
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

					cInfo.info.hp -= fInfo.hpHurt;
					trace("战斗结果->","源:"+fInfo.srcId,"对象:"+fInfo.objId,"伤害:"+fInfo.hpHurt,"技能:"+fInfo.skillID,"hp:"+cInfo.info.hp);
					if(target)
					{
						target.headEffect.setProgress(cInfo.info.hp,cInfo.info.hp_max);
						var targetSeq:LinerCmdSequence = new LinerCmdSequence();
						var onHurt:CmdOnHurt = new CmdOnHurt(target);
						onHurt.setHurt(fInfo.hpHurt,skill);
						targetSeq.addCommand(onHurt);
						targetSeq.addCommand(new CmdStand(target));
						target.createThread(targetSeq);
					}
					break;
				case FightEvent.FIGHT_DEATH:
					cInfo = {};
					fInfo = e.info;
					chara = getCharacterByID(fInfo.objType,fInfo.objId,cInfo);
					if(chara is Player)
					{
						dispatchEvent(new PlayerEvent(PlayerEvent.PLAYER_DIE,Player(chara).info));
					}
					else if(chara is Monster)
					{
						dispatchEvent(new MonsterEvent(MonsterEvent.MONSTER_DIE,Monster(chara).info));
					}
					chara.die();
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
			
			if(!target) return;
			
			var distX:Number = target.view.x - Player.self.view.x;
			var distY:Number = target.view.y - Player.self.view.y;
			var rad:Number = Math.atan2(distY,distX);
			var skills:Vector.<SkillInfo> = System.skill.getSkillsInBar();
			var random:uint = Math.random() * 8;
			var skill:SkillInfo = skills[random];
			trace(skill,skill.id,"skill");
			var attack:CmdSingleAtk = new CmdSingleAtk(Player.self);
			attack.setTarget(tgt);
			attack.skill = skill;
			
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
			Player.self.execute(seq);
		}
		
		public function update():void
		{
			
		}
	}
}
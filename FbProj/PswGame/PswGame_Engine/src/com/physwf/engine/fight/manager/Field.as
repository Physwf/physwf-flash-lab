package com.physwf.engine.fight.manager
{
	import com.physwf.components.command.LinerCmdSequence;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.command.CmdMultiAtk;
	import com.physwf.engine.common.command.CmdOnHurt;
	import com.physwf.engine.common.command.CmdSingleAtk;
	import com.physwf.engine.common.command.CmdStand;
	import com.physwf.engine.common.events.CharacterEvent;
	import com.physwf.engine.fight.Fight;
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
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * 战斗信息 
	 * @author joe
	 * 
	 */	
	public class Field extends EventDispatcher implements IUpdatable
	{
		public function Field()
		{
		}
		
		public function onWorldDestroy():void
		{
			System.fight.removeEventListener(FightEvent.FIGHT_RESULT,onFightEvent);
			System.fight.removeEventListener(FightEvent.FIGHT_DEATH,onFightEvent);
		}
		
		public function onWorldReady():void
		{
			System.fight.addEventListener(FightEvent.FIGHT_RESULT,onFightEvent);
			System.fight.addEventListener(FightEvent.FIGHT_DEATH,onFightEvent);
		}
		
		private function onFightEvent(e:FightEvent):void
		{
			var fInfo:FightInfo = e.info;
			var cInfo:Object = {};
			switch(e.type)
			{
				case FightEvent.FIGHT_RESULT:
					var srcChara:Character = getCharacterByID(fInfo.srcType,fInfo.srcId,cInfo);
					
					var objs:Vector.<FightObject> = fInfo.objects;
					var objTargets:Vector.<Character> = new Vector.<Character>();
					for(var i:uint =0 ;i<objs.length;++i)
					{
						var objChara:Character = getCharacterByID(objs[i].type,objs[i].id,cInfo)
						var hpHurt:uint = cInfo.info.hp - objs[i].hp;
						cInfo.info.hp = objs[i].hp;
//						trace("战斗结果->","源:"+fInfo.srcId,"对象:"+objs[i].id,"伤害:"+objs[i].hp,"技能:"+fInfo.skillID,"hp:"+cInfo.info.hp);
						if(objChara)
						{
							var targetSeq:LinerCmdSequence = new LinerCmdSequence();
							var onHurt:CmdOnHurt = new CmdOnHurt(objChara);
							onHurt.setHurt(hpHurt,null);
							targetSeq.addCommand(onHurt);
							objChara.createThread(targetSeq);
							targetSeq.execute();
							objTargets.push(objChara);
						}
					}
					if(srcChara == Player.self) return;
					var skill:SkillInfo = Engine.challenge.basicSkill;//temp
					if(objTargets.length>1)
					{
						var mAtk:CmdMultiAtk = new CmdMultiAtk(srcChara);
						mAtk.skill = skill;
						mAtk.setTargets(objTargets);
						var seq:LinerCmdSequence = new LinerCmdSequence();
						seq.addCommand(mAtk);
						seq.addCommand(new CmdStand(srcChara));
						srcChara.execute(seq);
					}
					else if(objTargets.length == 1)
					{
						var sAtk:CmdSingleAtk = new CmdSingleAtk(srcChara);
						sAtk.skill = skill;
						sAtk.setTarget(objTargets[0]);
						seq = new LinerCmdSequence();
						seq.addCommand(sAtk);
						seq.addCommand(new CmdStand(srcChara));
						srcChara.execute(seq);
					}
					break;
				case FightEvent.FIGHT_DEATH:
					cInfo = {};
					fInfo = e.info;
					objs = fInfo.objects;
					for(i =0 ;i<objs.length;++i)
					{
						srcChara = getCharacterByID(objs[i].type,objs[i].id,cInfo);
						if(srcChara is Player)
						{
							dispatchEvent(new CharacterEvent(CharacterEvent.PLAYER_DIE,srcChara));
						}
						else if(srcChara is Monster)
						{
							dispatchEvent(new CharacterEvent(CharacterEvent.MONSTER_DIE,srcChara));
							var mInfo:MonsterInfo = System.npc.getMonsInfoById(srcChara.id,true);
							Engine.map.delMonster(mInfo);
						}
						srcChara.die();
					}
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
				info_out.info = monster.info;
				return monster;
			}
			return null;
		}
		
		public function update():void
		{
		}
	}
}
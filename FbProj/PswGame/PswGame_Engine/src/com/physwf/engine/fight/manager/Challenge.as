package com.physwf.engine.fight.manager
{
	import com.physwf.components.command.LinerCmdSequence;
	import com.physwf.components.effects.BloodBar;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.Engine;
	import com.physwf.engine.command.CmdAttack;
	import com.physwf.engine.command.CmdGoTo;
	import com.physwf.engine.command.CmdGoToForAttack;
	import com.physwf.engine.command.CmdSingleAtk;
	import com.physwf.engine.command.CmdStand;
	import com.physwf.engine.fight.Fight;
	import com.physwf.engine.fight.controller.ChallengeController;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.engine.world.manager.Monster;
	import com.physwf.engine.world.manager.Player;
	import com.physwf.system.System;
	import com.physwf.system.entity.FightSystem;
	import com.physwf.system.events.FightEvent;
	import com.physwf.system.vo.FightInfo;
	import com.physwf.system.vo.SkillInfo;
	
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class Challenge implements IUpdatable
	{
		public var target:Character;//选中的目标
		public var basicSkill:SkillInfo;//基础技能
		public var selectSill:SkillInfo;//点击技能栏选择的技能
		
		private var targetID:uint = 0;
		private var controller:ChallengeController;
		private var lastAtk:uint = 0;
		
		private var bloodBars:Dictionary;
		
		public function Challenge()
		{
			Engine.challenge = this;
		}
		
		public function initialize():void
		{
			controller = new ChallengeController();
			controller.initialize(this);
			
			bloodBars = new Dictionary();
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
			switch(e.type)
			{
				case FightEvent.FIGHT_RESULT:
					var fInfo:FightInfo = e.info;
					var cInfo:Object = {};
					var chara:Character = getCharacterByID(fInfo.objType,fInfo.objId,cInfo);
					trace(cInfo.info.hp,"cInfo.info.hp")
					if(chara)
					{
//						chara.attack();
						trace(fInfo.hpHurt);
						updateBloodBar(fInfo.objId,chara,cInfo.info);
					}
					break;
				case FightEvent.FIGHT_DEATH:
					cInfo = {};
					fInfo = e.info;
					chara = getCharacterByID(fInfo.objType,fInfo.objId,cInfo);
					if(chara)
					{
						trace(fInfo.objId,"fInfo.objId");
						chara.die();
					}
					break;
			}
		}
		
		private function getCharacterByID(type:uint,id:uint,info_out:Object):Character
		{
			if(type == Fight.FIGHT_CHARA_TYPE_PLAYER)
			{
				var player:Player = Engine.map.getPlayerByUID(id);
				trace(player.info.hp,"player.info.hp");
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
				trace(monster.info.hp,"monster.info.hp");
				info_out.info = monster.info;
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
			var skill:SkillInfo = selectSill?selectSill:basicSkill;
			selectSill = null;
			
			var attack:CmdSingleAtk = new CmdSingleAtk(tgt);
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
		
		public function updateBloodBar(id:uint,chara:Character,info:*):void
		{
			var bar:BloodBar = bloodBars[id] as BloodBar;
			if(!bar)
			{
				bar = new BloodBar(Engine.map.view.upperEffect,chara.view,info);
				bloodBars[id] = bar;
			}
			bar.setProgress(info.hp,info.hp_max);
		}
	}
}
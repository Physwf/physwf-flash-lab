package com.physwf.engine.fight.manager
{
	import com.physwf.components.effects.BloodBar;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.Engine;
	import com.physwf.engine.command.CmdAtkMonster;
	import com.physwf.engine.command.CmdWalkTo;
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
	
	import flash.utils.getTimer;
	
	public class Challenge implements IUpdatable
	{
		public var target:Character;//选中的目标
		public var basicSkill:SkillInfo;//基础技能
		public var selectSill:SkillInfo;//点击技能栏选择的技能
		
		private var targetID:uint = 0;
		private var controller:ChallengeController;
		private var lastAtk:uint = 0;
		
		public function Challenge()
		{
			Engine.challenge = this;
		}
		
		public function initialize():void
		{
			System.fight.addEventListener(FightEvent.FIGHT_RESULT,onFightEvent);
			System.fight.addEventListener(FightEvent.FIGHT_DEATH,onFightEvent);
			controller = new ChallengeController();
			controller.initialize(this);
		}
		
		private function onFightEvent(e:FightEvent):void
		{
			switch(e.type)
			{
				case FightEvent.FIGHT_RESULT:
					var fInfo:FightInfo = e.info;
					var cInfo:* = {};
					var chara:Character = getCharacterByID(fInfo.objType,fInfo.objId,cInfo);
					if(chara)
					{
						chara.run();
						var bbar:BloodBar = new BloodBar(Engine.map.view.upperEffect,chara.view,cInfo.info);
					}
					break;
				case FightEvent.FIGHT_DEATH:
					fInfo = e.info;
					chara = getCharacterByID(fInfo.objType,fInfo.objId,cInfo);
					if(chara)
					{
						chara.die();
					}
					break;
			}
		}
		
		private function getCharacterByID(type:uint,id:uint,info_out:*):Character
		{
			if(type == Fight.FIGHT_CHARA_TYPE_PLAYER)
			{
				var player:Player = Engine.map.getPlayerByUID(id)
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
		
		public function setTarget(tgt:Character,id:uint):void
		{
			target = tgt;
			targetID = id;
			
			if(!target) return;
			
			var distX:Number = target.view.x - Player.self.view.x;
			var distY:Number = target.view.y - Player.self.view.y;
			var rad:Number = Math.atan2(distY,distX);
			var skill:SkillInfo = selectSill?selectSill:basicSkill;
			//当给角色指定攻击目标时，角色首先寻路到距离攻击目标在当前攻击技能的范围之内
			//这里寻路目标点的选择是用目标点所在位置减去角色方向的（长度为技能攻击范围的）一个线段而得到的点
			//有可能遇到的一个问题是，上述过程计算得到的点在地图上市不可走的，这将导致寻路失败。
			//可以将这种情况解释为角色与目标点之间有障碍物，无法攻击。
			//或者找到更好的一种计算方法
			var secureRange:uint = skill.range - 15;//保险范围，
			var targetX:uint = target.view.x - secureRange * Math.cos(rad);
			var targetY:uint = target.view.y - secureRange * Math.sin(rad);
			trace(targetX,targetY,"将要寻路到此");
			if((distX * distX + distY * distY) >= (skill.range * skill.range))
			{
				var walkCmd:CmdWalkTo = new CmdWalkTo(Player.self);
				walkCmd.setDest(targetX,targetY);
				controller.order(walkCmd);
			}
		}
		
		public function update():void
		{
			if(target)
			{
				var distX:Number = target.view.x - Player.self.view.x;
				var distY:Number = target.view.y - Player.self.view.y;
				var skill:SkillInfo = selectSill?selectSill:basicSkill;
				
				if((distX * distX + distY * distY) <= skill.range * skill.range)
				{
					if(getTimer() - lastAtk > 2000)
					{
						var atkCmd:CmdAtkMonster = new CmdAtkMonster(Player.self);
						atkCmd.setTarget(target,targetID);
						trace("进攻命令");
						controller.order(atkCmd);
						lastAtk = getTimer();
					}
				}
			}
		}
	}
}
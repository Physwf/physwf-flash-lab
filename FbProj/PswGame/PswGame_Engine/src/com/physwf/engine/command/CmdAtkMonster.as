package com.physwf.engine.command
{
	import com.physwf.components.effects.Effect;
	import com.physwf.components.effects.EffectConfig;
	import com.physwf.components.effects.EffectFactory;
	import com.physwf.engine.Engine;
	import com.physwf.engine.fight.Fight;
	import com.physwf.engine.fight.effects.EffectAssets;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.engine.world.manager.Player;
	import com.physwf.system.System;
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.Event;

	public class CmdAtkMonster extends Command
	{
		private var mChara:Character;
		private var target:Character;
		private var targetID:uint;
		
		public function CmdAtkMonster(chara:Character)
		{
			mChara = chara;
		}
		
		public function setTarget(tgt:Character,mid:uint):void
		{
			target = tgt;
			targetID = mid;
		}
		
		override public function execute():void
		{
			//如果 选择了技能则释放所选的技能否则释放基础技能
			var skill:SkillInfo = Engine.challenge.selectSill?Engine.challenge.selectSill:Engine.challenge.basicSkill;
			var skillID:uint = skill.id;
			var config:EffectConfig = EffectAssets.configs[skillID];
			var effect:Effect = EffectFactory.createEffect(config,Engine.map.view.upperEffect,target.view);
			mChara.attack();
			System.fight.attack(Fight.FIGHT_CHARA_TYPE_PLAYER,Fight.FIGHT_CHARA_TYPE_NPC,
								targetID,1);
			
			dispatchEvent(new Event(Command.FINISH));
		}
	}
}
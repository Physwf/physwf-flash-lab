package com.physwf.engine.command
{
	import com.physwf.components.command.Command;
	import com.physwf.components.effects.Effect;
	import com.physwf.components.effects.EffectConfig;
	import com.physwf.components.effects.EffectFactory;
	import com.physwf.engine.Engine;
	import com.physwf.engine.fight.Fight;
	import com.physwf.engine.fight.effects.EffectAssets;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.system.System;
	
	import flash.events.Event;

	/**
	 *单体攻击，只对一个目标进行攻击 
	 * @author joe
	 * 
	 */	
	public class CmdSingleAtk extends CmdAttack
	{
		private var mTarget:Character;
		
		public function CmdSingleAtk(chara:Character)
		{
			super(chara);
		}
		
		public function setTarget(target:Character):void
		{
			mTarget = target;
		}
		
		override public function execute():void
		{
			//如果 选择了技能则释放所选的技能否则释放基础技能
			var skillID:uint = mSkill.id;
			var config:EffectConfig = EffectAssets.configs[0];
			var effect:Effect = EffectFactory.createEffect(config,Engine.map.view.upperEffect,mTarget.view);
//			var effect:Effect = EffectFactory.createDiabloEffect(config,Engine.map.view.upperEffect,mTarget.view);
			effect.x = mChara.view.x;
			effect.y = mChara.view.y - 30;
			mChara.attack();
			System.fight.attack(Fight.FIGHT_CHARA_TYPE_PLAYER,Fight.FIGHT_CHARA_TYPE_NPC,mTarget.id,1);
			super.execute();
		}
	}
}
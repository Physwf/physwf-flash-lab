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
			//to do 特效
			var skillID:uint = Engine.challenge.selectSill.id;
			var config:EffectConfig = EffectAssets.configs[skillID];
			var effect:Effect = EffectFactory.createEffect(config,Engine.map.view.upperEffect,target.view);
			mChara.attack();
			System.fight.attack(Fight.FIGHT_CHARA_TYPE_PLAYER,Fight.FIGHT_CHARA_TYPE_NPC,
								targetID,1);
		}
	}
}
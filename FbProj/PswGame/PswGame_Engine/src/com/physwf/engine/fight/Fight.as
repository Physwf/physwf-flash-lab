package com.physwf.engine.fight
{
	import com.physwf.components.effects.BloodBar;
	import com.physwf.components.effects.Effect;
	import com.physwf.components.effects.TargetEffect;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.Engine;
	import com.physwf.engine.fight.effects.EffectSystem;
	import com.physwf.engine.fight.manager.Challenge;
	import com.physwf.engine.world.events.WorldEvent;
	import com.physwf.system.System;

	public class Fight implements IUpdatable
	{
		public static const FIGHT_CHARA_TYPE_PLAYER:uint = 1;
		public static const FIGHT_CHARA_TYPE_PET:uint = 2;
		public static const FIGHT_CHARA_TYPE_NPC:uint = 3;
		
		private var mChallenge:Challenge;
		
		public function Fight()
		{
		}
		
		public function initialize():void
		{
			mChallenge = new Challenge();
			mChallenge.initialize();
			mChallenge.basicSkill = System.skill.basicSill;
			
			Challenge.targetEffect = new TargetEffect(Engine.map.view.underEffect,0);
			Challenge.targetEffect.hide();
				
			Engine.map.addEventListener(WorldEvent.WORLD_DESTROY,onWorldDestroy);
			Engine.map.addEventListener(WorldEvent.WORLD_READY,onWorldReady);
		}
		
		private function onWorldDestroy(e:WorldEvent):void
		{
			mChallenge.onWorldDestroy();
		}
		
		private function onWorldReady(e:WorldEvent):void
		{
			mChallenge.onWorldReady();
		}
		
		public function update():void
		{
			mChallenge.update();
			
			var effects:Vector.<Effect> = Effect.effects;
			for(var i:uint=0;i<effects.length;++i)
			{
				Effect.effects[i].update();
			}
		}
	}
}
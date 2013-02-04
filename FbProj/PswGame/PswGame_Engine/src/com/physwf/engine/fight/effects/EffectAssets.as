package com.physwf.engine.fight.effects
{
	import com.physwf.components.effects.EffectConfig;
	import com.physwf.components.effects.VerticalEffect;

	public class EffectAssets
	{
		public static const DIR_EFFECT:String = "resource/effects/";
		
		public static const DROP_THOUDER:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+1,400);
		
		public function EffectAssets()
		{
			
		}
	}
}
package com.physwf.engine.fight.effects
{
	import com.physwf.components.effects.EffectConfig;

	public class EffectAssets
	{
		public static const DIR_EFFECT:String = "resource/effects";
		
		public static const DROP_THOUDER:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+1,300);
		
		public function EffectAssets()
		{
			
		}
	}
}
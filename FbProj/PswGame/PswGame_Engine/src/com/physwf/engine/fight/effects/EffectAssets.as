package com.physwf.engine.fight.effects
{
	import com.physwf.components.effects.DiabloEffect;
	import com.physwf.components.effects.EffectConfig;
	import com.physwf.components.effects.VerticalEffect;

	public class EffectAssets
	{
		public static const DIR_EFFECT:String = "resource/effects/";
		
		public static const DROP_THOUDER:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+1,400);
		public static const DROP_THOUDER2:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+2,400);
		public static const DROP_THOUDER3:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+3,400);
		public static const DROP_THOUDER4:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+4,400);
		public static const DROP_THOUDER5:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+5,400);
		public static const DROP_THOUDER6:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+6,400);
		public static const DROP_THOUDER7:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+7,400);
		public static const DROP_THOUDER8:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+8,400);
		public static const DROP_THOUDER9:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+9,400);
		public static const DROP_THOUDER10:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+10,400);
		public static const DROP_THOUDER11:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+11,400);
		public static const DROP_THOUDER12:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+12,400);
		public static const DROP_THOUDER13:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+13,400);
		public static const DROP_THOUDER14:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+14,400);
		public static const DROP_THOUDER15:EffectConfig = new EffectConfig(VerticalEffect,DIR_EFFECT+15,400);
		public static const BIG_HEAD:EffectConfig = new EffectConfig(DiabloEffect,DIR_EFFECT+16,400);
		
		public static var configs:Vector.<EffectConfig> = new <EffectConfig>
																			[
																				DROP_THOUDER,
																				DROP_THOUDER2,
																				DROP_THOUDER3,
																				DROP_THOUDER4,
																				DROP_THOUDER5,
																				DROP_THOUDER6,
																				DROP_THOUDER7,
																				DROP_THOUDER8,
																				DROP_THOUDER9,
																				DROP_THOUDER10,
																				DROP_THOUDER11,
																				DROP_THOUDER12,
																				DROP_THOUDER13,
																				DROP_THOUDER14,
																				DROP_THOUDER15,
																				BIG_HEAD
																			];
		
		public function EffectAssets()
		{
			
		}
	}
}
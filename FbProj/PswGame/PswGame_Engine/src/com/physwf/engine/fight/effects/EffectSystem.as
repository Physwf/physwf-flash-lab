package com.physwf.engine.fight.effects
{
	import com.physwf.components.effects.DiabloEffect;
	import com.physwf.components.effects.DiabloFactory;
	import com.physwf.components.effects.DropEffect;
	import com.physwf.components.effects.EffectConfig;
	import com.physwf.components.effects.EffectFactory;
	import com.physwf.components.effects.IEffectFactory;
	
	import mx.messaging.AbstractConsumer;

	public class EffectSystem
	{
		public static const DIR_EFFECT:String = "resource/effects/";
		
		public static const TYPE_NORMAL:uint = 1;
		public static const TYPE_DIABLO:uint = 2;
		
		// to do 建立特效配表 给每个忒小拟定名称 id 和 type
		public static const DROP_THOUDER:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+1,400);
		public static const DROP_THOUDER2:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+2,400);
		public static const DROP_THOUDER3:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+3,400);
		public static const DROP_THOUDER4:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+4,400);
		public static const DROP_THOUDER5:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+5,400);
		public static const DROP_THOUDER6:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+6,400);
		public static const DROP_THOUDER7:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+7,400);
		public static const DROP_THOUDER8:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+8,400);
		public static const DROP_THOUDER9:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+9,400);
		public static const DROP_THOUDER10:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+10,400);
		public static const DROP_THOUDER11:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+11,400);
		public static const DROP_THOUDER12:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+12,400);
		public static const DROP_THOUDER13:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+13,400);
		public static const DROP_THOUDER14:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+14,400);
		public static const DROP_THOUDER15:EffectConfig = new EffectConfig(DropEffect,DIR_EFFECT+15,400);
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
		
		public static var diabloFactory:DiabloFactory;
		public static var effectFactory:EffectFactory;
		
		public function EffectSystem()
		{
			
		}
		
		public static function initialize():void
		{
			diabloFactory = new DiabloFactory();
			effectFactory = new EffectFactory();
		}
		/**
		 * 根据特效的类型来选择特效工厂 
		 * @param type
		 * @return 
		 * 
		 */		
		public static function getFactory(type:uint):IEffectFactory
		{
			switch(type)
			{
				case TYPE_NORMAL:
					return effectFactory;
					break;
				case TYPE_DIABLO:
					return diabloFactory;
					break;
			}
			return null;
		}
		/**
		 * 根据特效的id来选择配置
		 * @return 
		 * 
		 */		
		public static function getConfig(id:uint):EffectConfig
		{
			return configs[id];
		}
	}
}
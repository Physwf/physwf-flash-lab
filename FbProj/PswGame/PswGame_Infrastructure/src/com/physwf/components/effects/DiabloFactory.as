package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	public class DiabloFactory implements IEffectFactory
	{
		private static var zeroEffects:Vector.<Vector.<EffectFrame>> = new <Vector.<EffectFrame>>[
			EffectFactory.zeroFrames,EffectFactory.zeroFrames,
			EffectFactory.zeroFrames,EffectFactory.zeroFrames,
			EffectFactory.zeroFrames,EffectFactory.zeroFrames,
			EffectFactory.zeroFrames,EffectFactory.zeroFrames
		];
		
		public function DiabloFactory()
		{
		}
		
		public function createEffect(config:EffectConfig,layer:Sprite,target:DisplayObject):Effect
		{
			var diablo:DiabloEffect = new config.Definition(layer,config.life,target);
			diablo.setEffects(zeroEffects);
			var dLoader:DiabloEffectLoader = DiabloEffectLoader.getSameDiabloLoader(config.url);
			function onComplete():void
			{
				dLoader.removeEventListener(Event.COMPLETE,onComplete);
				diablo.setEffects(dLoader.getEffects());
			};
			dLoader.addEventListener(Event.COMPLETE,onComplete);
			dLoader.load();
			
			return diablo;
		}
	}
}
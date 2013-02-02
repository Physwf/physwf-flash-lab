package com.physwf.components.effects
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	public class EffectFactory
	{
		private static var zeroEffects:Vector.<EffectFrame> = new <EffectFrame>[new EffectFrame(new BitmapData(1,1,true,0))];
		
		public function EffectFactory()
		{
		}
		
		public static function createEffect(config:EffectConfig,layer:Sprite,target:DisplayObject):Effect
		{
			var effect:Effect = new config.Definition(layer,config.life,target);
			var eLoader:EffectLoader = EffectLoader.getSameEffectLoader(config.url);
			function onComplete(e:Event):void
			{
				eLoader.removeEventListener(Event.COMPLETE,onComplete);
				effect.setFrames(eLoader.getFrames());
			};
			eLoader.addEventListener(Event.COMPLETE,onComplete);
			eLoader.load();
			effect.setFrames(zeroEffects);
			return effect;
		}
	}
}
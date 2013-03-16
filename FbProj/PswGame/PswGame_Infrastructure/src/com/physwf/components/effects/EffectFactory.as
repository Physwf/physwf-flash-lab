package com.physwf.components.effects
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	public class EffectFactory implements IEffectFactory
	{
		public static var zeroFrames:Vector.<EffectFrame> = new <EffectFrame>[new EffectFrame(new BitmapData(1,1,true,0))];
		
		public function EffectFactory()
		{
		}
		
		public function createEffect(config:EffectConfig,layer:Sprite,target:DisplayObject):Effect
		{
			var effect:Effect = new config.Definition(layer,config.life,target);
			effect.setFrames(zeroFrames);//必须放在load之前，否则将覆盖load完成时的setFrame
			var eLoader:EffectLoader = EffectLoader.getSameEffectLoader(config.url);
			function onComplete(e:Event):void
			{
				eLoader.removeEventListener(Event.COMPLETE,onComplete);
				effect.setFrames(eLoader.getFrames());
			};
			eLoader.addEventListener(Event.COMPLETE,onComplete);
			eLoader.load();
			
			return effect;
		}
	}
}
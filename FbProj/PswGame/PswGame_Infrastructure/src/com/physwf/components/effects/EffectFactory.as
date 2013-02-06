package com.physwf.components.effects
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	public class EffectFactory
	{
		private static var zeroFrames:Vector.<EffectFrame> = new <EffectFrame>[new EffectFrame(new BitmapData(1,1,true,0))];
		private static var zeroEffects:Vector.<Vector.<EffectFrame>> = new <Vector.<EffectFrame>>[
																									zeroFrames,zeroFrames,
																									zeroFrames,zeroFrames,
																									zeroFrames,zeroFrames,
																									zeroFrames,zeroFrames
																								];
		
		public function EffectFactory()
		{
		}
		
		public static function createEffect(config:EffectConfig,layer:Sprite,target:DisplayObject):Effect
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
		
		public static function createDiabloEffect(config:EffectConfig,layer:Sprite,target:DisplayObject):DiabloEffect
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
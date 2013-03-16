package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public interface IEffectFactory
	{
		function createEffect(config:EffectConfig,layer:Sprite,target:DisplayObject):Effect;
	}
}
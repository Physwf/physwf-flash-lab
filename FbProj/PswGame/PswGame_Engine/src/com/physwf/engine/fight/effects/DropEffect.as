package com.physwf.engine.fight.effects
{
	import com.physwf.components.effects.Effect;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class DropEffect extends Effect
	{
		public function DropEffect(layer:Sprite, life:uint, target:DisplayObject=null)
		{
			super(layer, life, target);
		}
	}
}
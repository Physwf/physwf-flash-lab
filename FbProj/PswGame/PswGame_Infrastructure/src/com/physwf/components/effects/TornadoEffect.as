package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * 旋风特效，垂直，平移
	 * @author Physwf
	 * 
	 */	
	public class TornadoEffect extends TrackEffect
	{
		public function TornadoEffect(layer:Sprite, life:uint, target:DisplayObject=null)
		{
			super(layer, life, target);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}
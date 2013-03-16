package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * 导弹特效，具有追击功能 
	 * @author Physwf
	 * 
	 */	
	public class MissileEffect extends TrackEffect
	{
		public function MissileEffect(layer:Sprite, life:uint, target:DisplayObject=null)
		{
			super(layer, life, target);
		}
	}
}
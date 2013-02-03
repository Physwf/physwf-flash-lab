package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * 追踪特效 
	 * @author Physwf
	 * 
	 */	
	public class TrackEffect extends Effect
	{
		public function TrackEffect(layer:Sprite, life:uint, target:DisplayObject=null)
		{
			super(layer, life, target);
		}
	}
}
package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * 子弹特效，特效体射出后不具有追踪功能 
	 * @author Physwf
	 * 
	 */	
	public class BulletEffect extends Effect
	{
		public function BulletEffect(layer:Sprite, life:uint, target:DisplayObject=null)
		{
			super(layer, life, target);
		}
	}
}
package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * 追踪特效 作为所有具有追踪性质的特效的基类
	 * @author Physwf
	 * 
	 */	
	public class TrackEffect extends Effect
	{
		protected var mSpeed:uint = 6;// to do 临时写死
		
		public function TrackEffect(layer:Sprite, life:uint, target:DisplayObject=null)
		{
			super(layer, life, target);
		}
		
		override public function update():void
		{
			var distX:int = mTarget.x - x;
			var distY:int = mTarget.y - y - 30;
			
			if(distX*distX + distY*distY < mSpeed)
			{
				mLayer.removeChild(this);
				effects.splice(effects.indexOf(this),1);
			}
		}
	}
}
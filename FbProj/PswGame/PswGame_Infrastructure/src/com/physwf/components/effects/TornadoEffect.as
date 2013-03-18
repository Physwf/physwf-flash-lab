package com.physwf.components.effects
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * 旋风特效，垂直，平移
	 * @author Physwf
	 * 
	 */	
	public class TornadoEffect extends Effect
	{
		private var mSpeed:uint = 8;
		private var mRad:Number = 0.0;
		
		public function TornadoEffect(layer:Sprite, life:uint, source:DisplayObject=null ,target:DisplayObject=null)
		{
			mRad = Math.atan2(target.y- source.y,target.x- source.x);
			super(layer, life, source, target);
		}
		
		override public function update():void
		{
			x += mSpeed * Math.cos(mRad);
			y += mSpeed * Math.sin(mRad);
			
			mCurFrame = mFrames[mCurFrameNum];
			mContent.x = mCurFrame.x;
			mContent.y = mCurFrame.y;
			mContent.bitmapData = mCurFrame.frameData;
			mCurFrameNum++;
			if(mCurFrameNum>=mTotalFrame)
			{
				mCurFrameNum = 0;
			}
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
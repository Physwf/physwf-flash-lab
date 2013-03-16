package com.physwf.components.effects
{
	import com.physwf.components.charactor.enum.ISODirection;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * 导弹特效，具有追击功能 
	 * @author Physwf
	 * 
	 */	
	public class MissileEffect extends DiabloEffect
	{
		
		public function MissileEffect(layer:Sprite, life:uint, target:DisplayObject=null)
		{
			super(layer, life, target);
		}
		
		override public function update():void
		{
			var distX:int = mTarget.x - x;
			var distY:int = mTarget.y - y - 30;
			var rad:Number = Math.atan2(distY,distX);
			var direct:int = ISODirection.radianToDirect16(rad);// 关键
			
			setFrames(mEffects[direct]);
			
			x += mSpeed * Math.cos(rad);
			y += mSpeed * Math.sin(rad);
			
			mCurFrame = mFrames[mCurFrameNum];
			mContent.x = mCurFrame.x;
			mContent.y = mCurFrame.y;
			mContent.bitmapData = mCurFrame.frameData;
			mCurFrameNum++;
			if(mCurFrameNum>=mTotalFrame)
			{
				mCurFrameNum = 0;
			}
			
			if(distX*distX + distY*distY < mSpeed)
			{
				mLayer.removeChild(this);
				effects.splice(effects.indexOf(this),1);
			}
		}
	}
}
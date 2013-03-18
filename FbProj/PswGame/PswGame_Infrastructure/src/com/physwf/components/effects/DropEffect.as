package com.physwf.components.effects
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.getTimer;

	/**
	 * 垂直降落特效，特效从目标头顶垂直降落，击中目标 
	 * @author Physwf
	 * 
	 */	
	public class DropEffect extends Effect
	{
		public function DropEffect(layer:Sprite, life:uint,source:DisplayObject=null, target:DisplayObject=null)
		{
			super(layer, life, source, target);
		}
		
		override public function update():void
		{
			// to do 目标应该增加攻击附着点，特效将在此点播放
			x = mTarget.x;
			y = mTarget.y - 30;
			//to do 
			mCurFrame = mFrames[mCurFrameNum];
			mContent.x = mCurFrame.x;
			mContent.y = mCurFrame.y;
			mContent.bitmapData = mCurFrame.frameData;
			mCurFrameNum++;
			if(mCurFrameNum>=mTotalFrame)
			{
				mCurFrameNum = 0;
			}
			if(getTimer() - mBornTime > mLife)
			{
				mLayer.removeChild(this);
				effects.splice(effects.indexOf(this),1);;
			}
		}
	}
}
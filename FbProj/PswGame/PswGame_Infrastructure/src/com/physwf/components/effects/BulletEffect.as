package com.physwf.components.effects
{
	import com.physwf.components.charactor.enum.ISODirection;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * 子弹特效，特效体射出后不具有追踪功能 
	 * @author Physwf
	 * 
	 */	
	public class BulletEffect extends DiabloEffect
	{
		private var mRad:Number = 0;
		private var mRange:uint = 150;// 射程，超出后，特效消失
		private var mPathLen:uint=0;
		
		public function BulletEffect(layer:Sprite, life:uint, source:DisplayObject=null ,target:DisplayObject=null)
		{
			mRad = Math.atan2(target.y-source.y,target.x-source.x);
			super(layer, life, target);
		}
		
		override public function setEffects(effects:Vector.<Vector.<EffectFrame>>):void
		{
			super.setEffects(effects);
			setFrames(mEffects[ ISODirection.radianToDirect8(mRad) ]);
		}
			
		override public function update():void
		{
			x += mSpeed * Math.cos(mRad);
			y += mSpeed * Math.sin(mRad);
			mPathLen += mSpeed;
			trace(mRad * 180/Math.PI,mPathLen);
			mCurFrame = mFrames[mCurFrameNum];
			mContent.x = mCurFrame.x;
			mContent.y = mCurFrame.y;
			mContent.bitmapData = mCurFrame.frameData;
			mCurFrameNum++;
			if(mCurFrameNum>=mTotalFrame)
			{
				mCurFrameNum = 0;
			}
			
			if(mPathLen > mRange)
			{
				mLayer.removeChild(this);
				effects.splice(effects.indexOf(this),1);
			}
			
		}
	}
}
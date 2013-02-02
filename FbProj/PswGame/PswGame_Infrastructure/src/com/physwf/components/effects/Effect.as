package com.physwf.components.effects
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	public class Effect extends Sprite implements IUpdatable, IDisposible
	{
		protected var mContent:Bitmap;
		protected var mTarget:DisplayObject;
		protected var mLayer:Sprite;
		protected var mLife:uint;//单位ms
		protected var mBornTime:uint;
		protected var mFrames:Vector.<EffectFrame>;
		protected var mTotalFrame:uint;
		protected var mCurFrameNum:uint;
		protected var mCurFrame:EffectFrame;
		
		public function Effect(layer:Sprite,life:uint,target:DisplayObject=null)
		{
			mLayer = layer;
			mLife = life;
			mTarget = target;
			
			mContent = new Bitmap();
			addChild(mContent);
			mLayer.addChild(this);
			mBornTime = getTimer();
		}
		
		public function update():void
		{
			x = mTarget.x;
			y = mTarget.y;
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
		}
		
		public function setFrames(frames:Vector.<EffectFrame>):void
		{
			mFrames = frames;
			mTotalFrame = mFrames.length;
			mCurFrameNum = 0;
		}
		
		public function destroy():void
		{
			if(mContent.bitmapData)
			{
				mContent.bitmapData.dispose();
			}
			mContent = null;
			mTarget = null;
			
			mLayer.removeChild(this);
		}
	}
}
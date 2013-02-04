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
		public static var effects:Vector.<Effect>;
		
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
			mouseEnabled = false;
			mouseChildren = false;
			mContent = new Bitmap();
			addChild(mContent);
			mLayer.addChild(this);
			mBornTime = getTimer();
			effects.push(this);
		}
		
		public function update():void
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
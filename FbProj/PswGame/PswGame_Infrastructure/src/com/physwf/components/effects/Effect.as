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
		public static const TYPE_VERTI_DROP:uint = 1;
		public static const TYPE_VERTI_TRAN:uint = 2;
		public static const TYPE_MISSILE_JET:uint = 3;
		public static const TYPE_MISSILE_TRACE:uint = 4;
		
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
		}
		
		public function setFrames(frames:Vector.<EffectFrame>):void
		{
			mFrames = frames;
			mTotalFrame = mFrames.length;
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
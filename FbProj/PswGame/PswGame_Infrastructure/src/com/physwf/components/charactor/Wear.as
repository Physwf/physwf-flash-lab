package com.physwf.components.charactor
{
	import com.physwf.components.bitmap.display.BitmapFrame;
	import com.physwf.components.bitmap.display.BitmapPalyer;
	import com.physwf.components.bitmap.net.SkeletonLoader;
	import com.physwf.components.charactor.enum.ISODirection;
	import com.physwf.components.view.IAnimation;
	
	import flash.display.Sprite;

	public class Wear implements IAnimation
	{
		public var mWear:BitmapPalyer;
		private var mWearBmdt:Vector.<Vector.<Vector.<BitmapFrame>>>;
		private var mSkeleton:SkeletonLoader;
		
		private var mDirect:uint;
		private var mAction:uint;
		private var mStatus:uint;
		private var mDirty:Boolean;
		private var mActionDirty:Boolean;
		
		public function Wear(layer:Sprite)
		{
			mWear = new BitmapPalyer();
			mWearBmdt = new Vector.<Vector.<Vector.<BitmapFrame>>>(ISODirection.NUM_DIRECTIONS,true);
			for(var i:int=0;i<ISODirection.NUM_DIRECTIONS;++i)
			{
				mWearBmdt[i] = new Vector.<Vector.<BitmapFrame>>(CharactorAnimation.NUM_ACTIONS,true);
			}
			layer.addChild(mWear);
		}
		
		public function set action(v:uint):void
		{
			mAction = v;
			mActionDirty = true;
			mDirty = true;
		}
		
		public function set direction(v:uint):void
		{
			mDirect = v;
			mDirty = true;
		}
		
		public function set skeleton(v:SkeletonLoader):void
		{
			mSkeleton = v;
		}
		
		public function set status(v:uint):void
		{
			mStatus = v;
			mDirty = true;
		}
		
		private function refresh():void
		{
			if(mActionDirty)
			{
				if(!mWearBmdt[mDirect][mAction])
				{
					mWearBmdt[mDirect][mAction] = mSkeleton.getCharacterAction(mDirect,mAction);
				}
				mWear.bitmapFrames = mWearBmdt[mDirect][mAction];
				mActionDirty = false;
			}
			else
			{
				if(!mWearBmdt[mDirect][mStatus])
				{
					mWearBmdt[mDirect][mStatus] = mSkeleton.getCharacterAction(mDirect,mStatus);
				}
				mWear.bitmapFrames = mWearBmdt[mDirect][mStatus];
			}
		}
		
		public function update():void
		{
			if(mDirty)
			{
				refresh();
				mDirty = false;
			}
			mWear.nextFrame();
		}
	}
}
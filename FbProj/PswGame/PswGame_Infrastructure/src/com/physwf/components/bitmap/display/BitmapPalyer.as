package com.physwf.components.bitmap.display {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;

	public class BitmapPalyer extends Bitmap {

		private var mBitmapFrames:Vector.<BitmapFrame>;
		private var mTotalFrames:int;
		public var currentFrame:int;
		
		public function BitmapPalyer() 
		{
		}
		
		public function nextFrame():void
		{
			if(!mBitmapFrames) return;
			if(currentFrame<0 || currentFrame>=mTotalFrames) currentFrame = 0;
			var keyFrame:BitmapKeyFrame = mBitmapFrames[currentFrame].keyFrame;
			if(bitmapData != keyFrame.bitmapData)
			{
				bitmapData = keyFrame.bitmapData;
				x=keyFrame.x;
				y=keyFrame.y;
			}
			currentFrame ++;
//			trace(currentFrame,name)
			if(currentFrame == mTotalFrames)
			{
				currentFrame = 0;
				dispatchEvent(new Event("complete"));
			}
		}
		
		public function set bitmapFrames(frames:Vector.<BitmapFrame>):void
		{
			mBitmapFrames = frames;
			mTotalFrames = mBitmapFrames.length;
			dispatchEvent(new Event("frame_changed"));
		}
		
		public function get bitmapFrames():Vector.<BitmapFrame>
		{
			return mBitmapFrames;
		}
		
		public function get totalFrames():int
		{
			return mTotalFrames;
		}

	} // end class
} // end package
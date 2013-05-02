package com.physwf.components.bitmap.display {

	import com.physwf.components.interfaces.IDisposible;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;

	public class BitmapPlayer extends Bitmap implements IDisposible {

		private var mBitmapFrames:Vector.<BitmapFrame>;
		private var mTotalFrames:int;
		public var currentFrame:int;
		
		public function BitmapPlayer() 
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

			if(currentFrame == mTotalFrames)
			{
				currentFrame = 0;
				dispatchEvent(new Event(Event.COMPLETE));
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
		
		public function destroy():void
		{
			mBitmapFrames = null;
		}
		
	} // end class
} // end package
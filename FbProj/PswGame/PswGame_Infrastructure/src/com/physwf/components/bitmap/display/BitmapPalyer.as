package com.physwf.components.bitmap.display {

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class BitmapPalyer extends Bitmap {

		public var bitmapFrames:Vector.<BitmapFrame>;
		public var currentFrame:int;
		
		public function BitmapPalyer() 
		{
		}
		
		public function nextFrame():void
		{
			if(currentFrame<0 || currentFrame>=bitmapFrames.length) currentFrame = 0;
			var keyFrame:BitmapKeyFrame = bitmapFrames[currentFrame].keyFrame;
			if(bitmapData != keyFrame.bitmapData)
			{
				bitmapData = keyFrame.bitmapData;
				x=keyFrame.x;
				y=keyFrame.y;
			}
			currentFrame ++;
		}

	} // end class
} // end package
package components.bitmap.display {
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import components.interfaces.IAnimation;
	import components.interfaces.IDisposible;
	
	public class BitmapPlayer extends Bitmap implements IDisposible ,IAnimation
	{
		public var interval:uint = 50;
		private var mBitmapFrames:Vector.<BitmapFrame>;
		private var mTotalFrames:int;
		private var mAccum:uint;
		public var currentFrame:int;
		
		public function BitmapPlayer() 
		{
		}
		
		public function step(step:uint):void
		{
			if(!mBitmapFrames || mBitmapFrames.length == 0) return;
			
			currentFrame+=step;
			if(currentFrame<0 || currentFrame>=mTotalFrames) currentFrame = 0;
			var frame:BitmapFrame = mBitmapFrames[currentFrame];
			if(bitmapData != frame.bitmapData)
			{
				bitmapData = frame.bitmapData;
				x=frame.x;
				y=frame.y;
			}
			
			if(currentFrame == mTotalFrames)
			{
				currentFrame = 0;
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function set bitmapFrames(frames:Vector.<BitmapFrame>):void
		{
			mBitmapFrames = frames;
			mTotalFrames = mBitmapFrames?mBitmapFrames.length:0;
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
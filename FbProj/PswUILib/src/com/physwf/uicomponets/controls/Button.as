package com.physwf.uicomponets.controls
{
	import com.physwf.uicomponets.Component;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	public class Button extends Component
	{
		private const STATE_UP:uint = 0;
		private const STATE_OVER:uint = 1;
		private const STATE_DOWN:uint = 2;
		private const STATE_GRAY:uint = 3;
		
		private var mDisplay:Bitmap;
		
		public function Button()
		{
			mDisplay = new Bitmap();
			addChild(mDisplay);
		}
		
		override protected function init():void
		{
			mDisplay.bitmapData = mTexture;
			mDisplay.scrollRect = mTexCoords[STATE_UP];
		}
	}
}
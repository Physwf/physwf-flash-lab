package com.physwf.components.ui.assets
{
	import com.physwf.components.interfaces.IDisposible;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class PanelAssets implements IDisposible
	{
		public var leftTop:BitmapData;
		public var top:BitmapData;
		public var rightTop:BitmapData;
		public var right:BitmapData;
		public var rightDown:BitmapData;
		public var down:BitmapData;
		public var leftDown:BitmapData;
		public var left:BitmapData;
		
		public var midle:BitmapData;
		
		public function PanelAssets()
		{
		}
		
		public function destroy():void
		{
			leftTop && leftTop.dispose();
			top &&　top.dispose();
			rightTop　&& rightTop.dispose();
			right　&& right.dispose();
			rightDown　&& rightDown.dispose();
			down　&& down.dispose();
			leftDown　&& leftDown.dispose();
			left　&& left.dispose();
		}
	}
}
package com.physwf.components.bitmap.display 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class BitmapKeyFrame {

		private var _bitmapData:BitmapData;
		
		public var x:int;

		public var y:int;
		
		public var rect:Rectangle;

		public function BitmapKeyFrame() 
		{
		}

		public function set bitmapData(v:BitmapData):void 
		{
			_bitmapData = v;
		}

		public function get bitmapData():BitmapData 
		{
			return _bitmapData;
		}

	} // end class
} // end package
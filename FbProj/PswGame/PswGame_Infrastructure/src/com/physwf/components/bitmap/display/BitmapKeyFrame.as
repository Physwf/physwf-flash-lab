package com.physwf.components.bitmap.display 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * 每个关键帧包含关键帧的位图数据和位图的坐标，以及位图的矩形数据 
	 * @author joe
	 * 
	 */
	public class BitmapKeyFrame {

		private var _bitmapData:BitmapData;
		
		public var x:int;

		public var y:int;
		
		public var rect:Rectangle;

		public function BitmapKeyFrame() 
		{
			_bitmapData = new BitmapData(1,1,true,0);
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
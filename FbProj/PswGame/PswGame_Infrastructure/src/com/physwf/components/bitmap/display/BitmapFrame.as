package com.physwf.components.bitmap.display {

	public class BitmapFrame 
	{
		public var frame:int;

		public var index:int;

		public var keyFrame:BitmapKeyFrame;

		/**
		 * 每一个普通帧都指向关键中包中的某一个位置（通过frame属性）  
		 * 
		 */
		public function BitmapFrame() 
		{
		}

	} // end class
} // end package
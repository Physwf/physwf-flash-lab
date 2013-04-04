package com.physwf.components.pswloader
{
	/**
	 * 用来加载地图切片 
	 * @author Physwf
	 * 
	 */	
	public class PieceItem extends ImageItem
	{
		private var mX:uint;//切片的x坐标
		public function get x():uint { return x; }
		private var mY:uint;//切片的y坐标
		public function get y():uint { return y; }
		
		public function PieceItem(url:String, uid:String,x:uint,y:uint,postfix:String=".jpg")
		{
			mUrl = url + x + "_" + y + postfix;
			mX = x;	 mY = y;
			super(mUrl, uid);
		}
	}
}
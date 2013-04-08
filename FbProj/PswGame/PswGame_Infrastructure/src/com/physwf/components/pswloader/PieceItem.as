package com.physwf.components.pswloader
{
	/**
	 * 用来加载地图切片 
	 * @author Physwf
	 * 
	 */	
	public class PieceItem extends ImageItem
	{
		public var x:uint;//切片的x坐标
		public var y:uint;//切片的y坐标
		
		public function PieceItem(url:String, uid:String,...args)
		{
			var postfix:String = args[0]?args[0]:".jpg";
			mUrl = url+postfix;
			super(mUrl, uid);
		}
	}
}
package com.physwf.uicomponets
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * 所有的组件基类。
	 * 该组件包含且只包含一个位图，位图的数据为一个精灵图序列，通过指定位图的scrollRect属性来选取精灵图序列中的某一个内容，从而初始化或者改变组件的状态。 
	 * @author Joe Physwf
	 * 
	 */	
	public class Component extends Sprite
	{
		protected var mTexture:BitmapData;
		protected var mTexCoords:Vector.<Rectangle>;//纹理坐标
		
		public function Component()
		{
			super();
			mTexCoords = new Vector.<Rectangle>();
		}
		/**
		 * 设置组建的纹理和坐标 
		 * @param tex
		 * @param coords
		 * 
		 */		
		public function setTexAndCoords(tex:BitmapData,coords:Vector.<Rectangle>):void
		{
			mTexture = tex;
			mTexCoords = coords;
			init();
		}
		/**
		 * 设置纹理后悔调用该初始化方法。 
		 * 
		 */		
		protected function init():void
		{
			
		}
	}
}
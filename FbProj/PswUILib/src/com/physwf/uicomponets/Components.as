package com.physwf.uicomponets
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * 所有的组件基类。
	 * 该组件包含且只包含一个位图，位图的数据为一个精灵图序列，通过指定位图的scrollRect属性来选取精灵图序列中的某一个内容，从而初始化或者改变组件的状态。 
	 * @author yuelei.qiao
	 * 
	 */	
	public class Components extends Sprite
	{
		protected var mDisplay:Bitmap;
		protected var mSpriteSheet:BitmapData;
		protected var mStates:Vector.<Rectangle>;//组件的各种状态，可能只有一个
		
		public function Components()
		{
			super();
			mDisplay = new Bitmap();
			addChild(mDisplay);
			mStates = new Vector.<Rectangle>();
		}
	}
}
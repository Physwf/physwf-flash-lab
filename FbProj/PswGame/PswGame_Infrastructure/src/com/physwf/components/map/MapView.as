package com.physwf.components.map
{
	import com.physwf.components.map.wayfinding.astar.BiHeapAStar;
	import com.physwf.components.map.wayfinding.astar.IAstar;
	import com.physwf.components.map.wayfinding.astar.Node;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class MapView extends Sprite
	{
		private var mBottom:Sprite;
		private var mUnderEffect:Sprite;//底部特效层
		private var mSwap:Sprite;//交换层
		private var mUpperEffct:Sprite;//顶部特效层
		private var mLandform:DisplayObject;
		private var mMapW:Number;
		private var mMapH:Number;
		
		public function MapView()
		{
			mBottom = new Sprite();
			mUnderEffect = new Sprite();
			mSwap = new Sprite();
			mUpperEffct = new Sprite();
			addChild(mBottom);
			addChild(mUnderEffect);
			addChild(mSwap);
			addChild(mUpperEffct);
		}
		
		public function fillBottom(v:DisplayObject):void
		{
			mMapW = v.width;
			mMapH = v.height;
			mBottom.addChild(v);
		}
		/**
		 * 
		 * 后面要考虑大对象集中销毁的性能影响，将其在时间上分散开来销毁
		 */
		public function clearBottom():void
		{
			if(mBottom.numChildren == 0) return;
			var content:Bitmap = mBottom.removeChildAt(0) as Bitmap;
			if(content) content.bitmapData.dispose();
		}
		
		public function addSwapElement(element:DisplayObject):DisplayObject
		{
			return mSwap.addChild(element);
		}
		
		public function removeSwapElement(element:DisplayObject):DisplayObject
		{
			return mSwap.removeChild(element);
		}
		
		public function get bottom():Sprite
		{
			return mBottom;
		}
		
		public function get swapLayer():Sprite
		{
			return mSwap;
		}
		
		public function set landform(v:DisplayObject):void
		{
			mLandform = v;
		}
		
		public function get landform():DisplayObject
		{
			return mLandform;
		}
		
		public function get underEffect():Sprite
		{
			return mUnderEffect;
		}
		
		public function get upperEffect():Sprite
		{
			return mUpperEffct;
		}
		
		public function get mapWidth():Number
		{
			return mMapW;
		}
		
		public function get mapHeight():Number
		{
			return mMapH;
		}
	}
}
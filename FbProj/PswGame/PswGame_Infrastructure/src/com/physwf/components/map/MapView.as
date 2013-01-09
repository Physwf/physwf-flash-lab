package com.physwf.components.map
{
	import com.physwf.components.map.wayfinding.astar.BiHeapAStar;
	import com.physwf.components.map.wayfinding.astar.IAstar;
	import com.physwf.components.map.wayfinding.astar.Node;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class MapView extends Sprite
	{
		private var mBottom:Sprite;
		private var mSwap:Sprite;//交换层
		private var mLandform:DisplayObject;
		private var mMapW:Number;
		private var mMapH:Number;
		
		public function MapView()
		{
			mBottom = new Sprite();
			mSwap = new Sprite();
			addChild(mBottom);
			addChild(mSwap);
		}
		
		public function fillBottom(v:DisplayObject):void
		{
			mMapW = v.width;
			mMapH = v.height;
			mBottom.addChild(v);
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
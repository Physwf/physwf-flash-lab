package com.physwf.components.map
{
	import com.physwf.components.map.wayfinding.astar.BiHeapAStar;
	import com.physwf.components.map.wayfinding.astar.IAstar;
	import com.physwf.components.map.wayfinding.astar.Node;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Map extends Sprite
	{
		private var mBottom:Sprite;
		private var mLandform:DisplayObject;
		private var mAstar:IAstar;
		private var mMapW:Number;
		private var mMapH:Number;
		
		public function Map()
		{
			mBottom = new Sprite();
			addChild(mBottom);
			mAstar = new BiHeapAStar();
		}
		
		public function fillBottom(v:DisplayObject):void
		{
			mMapW = v.width;
			mMapH = v.height;
			mBottom.addChild(v);
		}
		
		public function get bottom():Sprite
		{
			return mBottom;
		}
		
		public function set landform(v:DisplayObject):void
		{
			mLandform = v;
			mAstar.analyze(mLandform);
		}
		
		public function getPath(start:Point,end:Point):Vector.<Node>
		{
			if(mAstar.tryFindPath(start.x,start.y,end.x,end.y))
				return mAstar.getPath();
			else return null;
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
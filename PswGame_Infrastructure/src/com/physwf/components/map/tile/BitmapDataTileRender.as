package com.physwf.components.map.tile
{
	import com.physwf.components.ds.tree.QuadTree;
	import com.physwf.components.interfaces.IMeasurable;
	import com.physwf.components.map.TileBasedMap;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class BitmapDataTileRender implements ITileRender
	{
		private var _objVec:Vector.<IMeasurable>;
		private var _sRect:Rectangle;// screen rect
		private var _cacheRect:Rectangle; // cache rect
		private var _qTree:QuadTree;
		private var _mapDisplayCache:BitmapData;
		
		public function BitmapDataTileRender(bmd:BitmapData)
		{
			_mapDisplayCache = bmd;
			init();
		}
		
		private function init():void
		{
			_qTree = new QuadTree(6,new Rectangle(0,0,TileBasedMap.W,TileBasedMap.H));
			for(var i:int =0;i<100;++i)
			{
				for(var j:int=0;j<100;++j)
				{
					var tile:ITile = new BitmapDataTile(_mapDisplayCache);
					tile.setIndex(i,j);
					_qTree.insertObj(tile);
				}
			}
		}
		
		public function set screenRect(v:Rectangle):void
		{
			_sRect = v;
			_cacheRect = new Rectangle(0,0,_sRect.width+400,_sRect.height+400);
		}
		
		public function get screenRect():Rectangle
		{
			return _sRect;
		}
		
		public function render():void
		{
//			return;
			_cacheRect.x = _sRect.x-200;
			_cacheRect.y = _sRect.y-200;
			
			var cacheTileVec:Vector.<IMeasurable> = _qTree.searchByRect(_cacheRect,true);
			var screenTileVec:Vector.<IMeasurable> = _qTree.searchByRect(_sRect,true);
			var len:uint = cacheTileVec.length;
			var tile:ITile;
			
			for(var i:int=0;i<len;++i)
			{
				tile = cacheTileVec[i] as ITile;
				if(screenTileVec.indexOf(tile)>-1)
				{
					tile.install();
				}
				else
				{
					tile.uninstall();
				}
			}
			
//			_mapDisplayCache.scroll(-1,0);
		}
	}
}
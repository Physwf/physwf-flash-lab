package com.physwf.components.map.layer.tile
{
	import com.physwf.components.ds.tree.QuadTree;
	import com.physwf.components.interfaces.IMeasurable;
	import com.physwf.components.map.MapBase;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class BitmapTileController implements ITileController
	{
		private var _objVec:Vector.<IMeasurable>;
		private var _sRect:Rectangle;// screen rect
		private var _cacheRect:Rectangle; // cache rect
		private var _qTree:QuadTree;
		private var _mapDisplay:Sprite;
		
		public function BitmapTileController(mapDisplay:Sprite)
		{
			_mapDisplay = mapDisplay;
			init();
		}
		
		private function init():void
		{
			_qTree = new QuadTree(4,new Rectangle(0,0,MapBase.W,MapBase.H));
			for(var i:int =0;i<50;++i)
			{
				for(var j:int=0;j<50;++j)
				{
					var tile:ITile = new BitmapTile(_mapDisplay);
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
			
		}
	}
}
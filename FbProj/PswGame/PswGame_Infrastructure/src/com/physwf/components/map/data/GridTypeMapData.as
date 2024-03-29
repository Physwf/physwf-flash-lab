package com.physwf.components.map.data
{
	import com.physwf.components.map.wayfinding.astar.Node;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	/**
	 * 栅格类型的地图数据 
	 * @author joe
	 * 
	 */	
	public class GridTypeMapData
	{
		public static const GRID_SIZE:uint = 10;
		
		private var _startNode:Node;
		private var _endNode:Node;
		
		private var _numNodeX:uint;
		private var _numNodeY:uint;
		
		private var _nodeList:Vector.<Vector.<Node>>;
		
		public function GridTypeMapData()
		{
			
		}
		
		public function initialize(landform:DisplayObject, rect:Rectangle):void
		{
			var bmd:BitmapData = new BitmapData(rect.width,rect.height,true,0);
			bmd.draw(landform);
			_numNodeX = Math.round(rect.width / GRID_SIZE);
			_numNodeY = Math.round(rect.height / GRID_SIZE);
			
			_nodeList = new Vector.<Vector.<Node>>(_numNodeX);
			for(var x:uint=0;x<_numNodeX;++x)
			{
				_nodeList[x] = new Vector.<Node>(_numNodeY);
				for(var y:uint =0;y<_numNodeY;++y)
				{
					_nodeList[x][y] = new Node(x,y);
					var _x:uint = x * GRID_SIZE - GRID_SIZE * .5;
					var _y:uint = y * GRID_SIZE - GRID_SIZE * .5;
					_nodeList[x][y].type = bmd.getPixel(_x,_y);
				}
			}
		}
		
		public function getNode(x:int, y:int):Node
		{
			if(x < 0 || y <0 ) return null;
			if(x >= _numNodeX || y >= _numNodeY) return null;
			return _nodeList[x][y];
		}
		
		public function setStartNode(x:int, y:int):Node
		{
			return _startNode = _nodeList[x][y];
		}
		
		public function setEndNode(x:int, y:int):Node
		{
			return _endNode = _nodeList[x][y];
		}
		
		public function get startNode():Node
		{
			return _startNode;
		}
		
		public function get endNode():Node
		{
			return _endNode;
		}
	}
}
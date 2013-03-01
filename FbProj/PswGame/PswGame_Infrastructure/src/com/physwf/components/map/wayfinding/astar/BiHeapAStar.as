package com.physwf.components.map.wayfinding.astar
{
	import com.physwf.components.ds.heap.MinHeap;
	import com.physwf.components.map.data.GridTypeMapData;
	
	import flash.display.DisplayObject;
	import flash.utils.getTimer;

	/**
	 * 二叉堆寻路 
	 * @author joe
	 * 
	 */
	public class BiHeapAStar implements IAstar
	{
		private var _mapData:GridTypeMapData;
		private var _openList:MinHeap;
		private var _closedList:Vector.<Node>;
		private var _path:Vector.<Node>;
		private var _pathLine:Vector.<Line>;
		
		private var _startNode:Node;
		private var _endNode:Node;
		
		private var _heuristic:Function = diagonal;
		
		private var _straightCost:Number = 1.0;
		private var _diagCost:Number = Math.SQRT2;
		
		public function BiHeapAStar()
		{
			_mapData = new GridTypeMapData();
		}
		
		public function analyze(landform:DisplayObject):void
		{
			_mapData.initialize(landform,landform.getRect(landform));
		}
		
		public function tryFindPath(sx:int, sy:int, ex:int, ey:int):Boolean
		{
			_startNode = _mapData.setStartNode(sx,sy);
			_endNode = _mapData.setEndNode(ex,ey);
			
			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode);
			_startNode.f = _startNode.g + _startNode.h;
			
			_openList = new MinHeap(100000);
			_closedList = new Vector.<Node>();
			
			return search();
		}
		
		private function search():Boolean
		{
			trace("开始寻路",getTimer());
			if(_startNode == _endNode) return false;
			var minCostNode:Node = _startNode;
			if(!_endNode.walkable) return false;//由于地图过大，试图寻路到不可达区域将会严重耗时
			while(minCostNode != _endNode)
			{
				var neerNode:Node;
				var x:int,y:int;
				for(var dx:int=-1;dx<=1;++dx)
				{
					x = minCostNode.x + dx;
					for(var dy:int=-1;dy<=1;++dy)
					{
						y=minCostNode.y+dy;
						neerNode = _mapData.getNode(x,y);
						if(!neerNode) continue;
						if(neerNode == minCostNode) continue;
						if(!neerNode.walkable) continue;
						var selfCost:Number = _diagCost;
						if(minCostNode.x == x || minCostNode.y == y)
						{
							selfCost = _straightCost;
						}
						var gSum:Number = minCostNode.g + selfCost //* neerNode.costMultiply;
						var h:Number = _heuristic(neerNode);
						var f:Number = gSum + h;
//						if(_openList.hasItem(neerNode) || (_closedList.indexOf(neerNode)>-1))
						if((_openList.hasItem(neerNode)) || (_closedList.indexOf(neerNode)>-1))
						{
							if(neerNode.f > f)
							{
								neerNode.f = f;
								neerNode.g = gSum;
								neerNode.h = h;
								neerNode.parent = minCostNode;
							}
						}
						else
						{
							neerNode.f = f;
							neerNode.g = gSum;
							neerNode.h = h;
							neerNode.parent = minCostNode;
							_openList.Enqueue(neerNode);
						}//end if
					}//end for y
				}//end for x
				
				_closedList.push(minCostNode);
				if(!_openList.size) return false;//no path found
				
				minCostNode = _openList.Dequeue() as Node;
			}//end while
			buildPath();
			trace("寻路结束",getTimer())
			return true;
		}
		
		private function buildPath():void
		{
			_path = new Vector.<Node>();
			_pathLine = new Vector.<Line>();
			
			var node:Node = _endNode;
			var line:Line;
			while(node != _startNode)
			{
				line = new Line(node.parent,node);
				_pathLine.unshift(line);
				node = node.parent;
			}
			
			floyd();
		}
		/**
		 * 合并在同一方向上的点(8个可能的方向),该思想参见http://wonderfl.net/c/aWCe或http://www.iamsevent.com/post/34.html
		 */		
		private function floyd():void
		{
			var len:uint = _pathLine.length
			if(len>1)
			{
				var i:uint=0;
				while(true)
				{
					if(_pathLine[i].directRad == _pathLine[i+1].directRad)
					{
						_pathLine[i+1].sx = _pathLine[i].sx;
						_pathLine[i+1].sy = _pathLine[i].sy;
						_pathLine.splice(i,1);
						len--;
					}
					else
					{
						i++;
					}
					if(len-i<2) break;
				}
			}
		}
		
		private function manhattan(node:Node):Number
		{
			return (Math.abs(node.x - _endNode.x ) + Math.abs(node.y - _endNode.y )) * _straightCost;
		}
		
		private function euclidian(node:Node):Number
		{
			var dx:int = node.x - _endNode.x;
			var dy:int = node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy ) *  _straightCost;
		}
		
		private function diagonal(node:Node):Number
		{
			var dx:int = Math.abs(node.x - _endNode.x);
			var dy:int = Math.abs(node.y - _endNode.y);
			var diag:int = Math.min(dx,dy);
			var straight:int = dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag)
		}
		
		public function getPath():Vector.<Node>
		{
			return _path;
		}
		
		public function getPathLine():Vector.<Line>
		{
			return _pathLine;
		}
		
		public function set mapData(data:GridTypeMapData):void
		{
			_mapData = data;
		}
		
		public function get mapData():GridTypeMapData
		{
			return _mapData;
		}
		
		
	}
}
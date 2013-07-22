package components.map.wayfinding.astar
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import components.ds.heap.MinHeap;
	import components.map.data.GridTypeMapData;
	
	public class AsynBiHeapAstar extends EventDispatcher implements IAstar
	{
		private static var _mapData:GridTypeMapData;
		
		private var _openList:MinHeap;
		//		private var _closedList:Vector.<Node>;
		private var _closeDic:Dictionary;
		private var _path:Vector.<Node>;
		private var _pathLine:Vector.<Line>;
		
		private var _startNode:Node;
		private var _endNode:Node;
		
		private var _minCostNode:Node;
		private var _startLoop:Boolean = false;
		
		private var _heuristic:Function = diagonal;
		
		private var _straightCost:Number = 1.0;
		private var _diagCost:Number = Math.SQRT2;
		
		public function AsynBiHeapAstar()
		{
		}
		
		public function analyze(navData:Vector.<int>, row:uint, column:uint):void
		{
			_mapData = new GridTypeMapData();
			_mapData.initialize(navData,row,column);
		}
		
		public function tryFindPath(sx:int, sy:int, ex:int, ey:int):Boolean
		{
			_startNode = _mapData.setStartNode(sx,sy);
			_endNode = _mapData.setEndNode(ex,ey);
			
			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode);
			_startNode.f = _startNode.g + _startNode.h;
			
			_openList = new MinHeap(10000);
			//			_closedList = new Vector.<Node>();
			_closeDic = new Dictionary();
			
			var start:uint = getTimer()
			//			trace("开始寻路",getTimer());
			if(_startNode == _endNode) 
			{
				return false;
			}
			if(!_endNode.walkable) 
			{
				return false;//由于地图过大，试图寻路到不可达区域将会严重耗时
			}
			_minCostNode = _startNode;
			
			_startLoop = true;
			
			return true;
		}
		
		public function update(delta:uint):void
		{
			if(!_startLoop) return;
			var timeout:Boolean =false;
			var start:uint = getTimer();
			while(_minCostNode != _endNode)
			{
				var neerNode:Node;
				var x:int,y:int;
				for(var dx:int=-1;dx<=1;++dx)
				{
					x = _minCostNode.x + dx;
					for(var dy:int=-1;dy<=1;++dy)
					{
						y=_minCostNode.y+dy;
						neerNode = _mapData.getNode(x,y);
						if(!neerNode) continue;
						if(neerNode == _minCostNode) continue;
						if(!neerNode.walkable) continue;
						var selfCost:Number = _diagCost;
						if(_minCostNode.x == x || _minCostNode.y == y)
						{
							selfCost = _straightCost;
						}
						var gSum:Number = _minCostNode.g + selfCost //* neerNode.costMultiply;
						var h:Number = _heuristic(neerNode);
						var f:Number = gSum + h;
						//						if(_openList.hasItem(neerNode) || (_closedList.indexOf(neerNode)>-1))
						if((_openList.hasItem(neerNode)) || _closeDic[neerNode] != null)
						{
							if(neerNode.f > f)
							{
								neerNode.f = f;
								neerNode.g = gSum;
								neerNode.h = h;
								neerNode.parent = _minCostNode;
							}
						}
						else
						{
							neerNode.f = f;
							neerNode.g = gSum;
							neerNode.h = h;
							neerNode.parent = _minCostNode;
							_openList.Enqueue(neerNode);
						}//end if
					}//end for y
				}//end for x
				
				//				_closedList.push(minCostNode);
				_closeDic[_minCostNode] = true;//为了效率的考虑将关闭节点放入一个哈希表（Dictionary）中，通过对象作为键值来访问节点是否存在关闭节点中
				if(!_openList.size) 
				{
					_startLoop = false;
//					trace("no path");
					//return false;//no path found
				}
				
				_minCostNode = _openList.Dequeue() as Node;
				if(getTimer() - start > 5)
				{
					timeout = true;
//					trace("time out")
					break;
				}
			}//end while
			
			if(!timeout)
			{
				_startLoop = false;
				buildPath();
			}
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
			
			dispatchEvent(new Event(Event.COMPLETE));
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
		
		public function get mapData():GridTypeMapData
		{
			return _mapData;
		}
	}
}
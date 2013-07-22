package components.map.wayfinding.astar
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import components.ds.heap.MinHeap;
	import components.map.data.GridTypeMapData;

	public class BFS implements IAstar
	{
		private var _startNode:Node;
		private var _endNode:Node;
		
		private var _mapData:GridTypeMapData;
		
		private var _path:Vector.<Node>;
		private var _pathLine:Vector.<Line>;
		
		public function BFS()
		{
			_mapData = new GridTypeMapData();
		}
		
		public function analyze(navData:Vector.<int>,row:uint,column:uint):void
		{
			_mapData.initialize(navData,row,column);
		}
		
		public function tryFindPath(sx:int, sy:int, ex:int, ey:int):Boolean
		{
			var start:uint = getTimer();
			
			_startNode = _mapData.setStartNode(sx,sy);
			_endNode = _mapData.setEndNode(ex,ey);
			
			if(_startNode == _endNode) return false;
			if(!_endNode.walkable) return false;
			
			var i:uint=0;
			_startNode.f = i;
			var queue:MinHeap = new MinHeap(100);
			queue.Enqueue(_startNode);
			var neighbor:Node;
			var testedNodes:Dictionary = new Dictionary();
			
			while(queue.size>0)
			{
				var testNode:Node = queue.Dequeue() as Node;
				i++;
				var x:int,y:int;
				for(var dx:int=-1;dx<=1;++dx)
				{
					x = testNode.x + dx;
					for(var dy:int=-1;dy<=1;++dy)
					{
						y = testNode.y+dy;
						neighbor = _mapData.getNode(x,y);
						if(testedNodes[neighbor]) continue;
						testedNodes[neighbor] = true;
						if(!neighbor) continue;
						if(!neighbor.walkable) continue;
						
						if(testNode.x != x && testNode.y != y)
						{
							if(!_mapData.getNode(x-dx,y).walkable && !_mapData.getNode(x,y-dy).walkable) continue;
						}
						neighbor.parent = testNode;
						neighbor.f = i;
						if(neighbor == _endNode)
						{
							trace("BFS寻路,找到终点:",getTimer() - start + "ms");
							start = getTimer();
							buildPath();
							trace("BFS寻路,建立路径:",getTimer() - start + "ms");
							return true;
						}
						queue.Enqueue(neighbor);
					}
				}
			}
			return false;
		}
		
		private function buildPath():void
		{
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
			i = 1;
			while(i<_pathLine.length)
			{
				var sx:Number = _pathLine[i-1].sx / GridTypeMapData.GRID_SIZE;
				var sy:Number = _pathLine[i-1].sy / GridTypeMapData.GRID_SIZE;
				var ex:Number = _pathLine[i].ex / GridTypeMapData.GRID_SIZE;
				var ey:Number = _pathLine[i].ey / GridTypeMapData.GRID_SIZE;
				var dx:int = ex - sx;
				var dy:int = ey - sy;
				len = Math.max(Math.abs(dx),Math.abs(dy));
				var stepX:Number = dx / len;
				var stepY:Number = dy / len;
				var block:Boolean = false;
				for(var j:uint=1;j<len-1;++j)
				{
					var x:uint = Math.floor(sx+stepX * j);
					var y:uint = Math.floor(sy+stepY * j);
					if(!_mapData.getNode(x,y).walkable)
					{
						block = true;
						break;
					}
				}
				if(block)
				{
					i++;
				}
				else
				{
					_pathLine[i].sx = _pathLine[i-1].sx;
					_pathLine[i].sy = _pathLine[i-1].sy;
					_pathLine.splice(i-1,1);
				}
				
			}
		}
		
		public function getPath():Vector.<Node>
		{
			return null;
		}
		
		public function getPathLine():Vector.<Line>
		{
			return _pathLine;
		}
	}
}
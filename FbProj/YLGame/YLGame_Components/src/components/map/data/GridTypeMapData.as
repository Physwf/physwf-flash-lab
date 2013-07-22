package components.map.data
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import components.map.wayfinding.astar.ISOCoordUtils;
	import components.map.wayfinding.astar.Node;
	
	/**
	 * 栅格类型的地图数据 
	 * @author joe
	 * 
	 */	
	public class GridTypeMapData
	{
		public static const GRID_SIZE:uint = 32;
		
		private var _startNode:Node;
		private var _endNode:Node;
		
		private var _numNodeX:uint;
		private var _numNodeY:uint;
		
		private var _nodeList:Vector.<Vector.<Node>>;
		
		
		public function GridTypeMapData()
		{
		}
		
		public function initialize(navData:Vector.<int>,numNodeX:uint,numNodeY:uint):void
		{
			_numNodeX = numNodeX;
			_numNodeY = numNodeY;
			_nodeList = new Vector.<Vector.<Node>>(_numNodeX,true);
			for(x=0;x<_numNodeX;++x)
			{
				_nodeList[x] = new Vector.<Node>(_numNodeY,true);
				for(y =0;y<_numNodeY;++y)
				{
					_nodeList[x][y] = new Node(x, y);
					_nodeList[x][y].type = navData[y*numNodeX+x] > 0 ? 0 : 1;
				}
			}
			return;
			var max:Point = ISOCoordUtils.screenToGame(numNodeY,numNodeX);
			var canvas:BitmapData = new BitmapData(max.y, max.y,true,0 );
			for(var x:uint=0;x<numNodeX;++x)
			{
				for(var y:uint =0;y<numNodeY;++y)
				{
					var color:uint = navData[x*numNodeX + y] != 0 ? 0x7F000000 : 0x7f0000ff;
					var nodeBmd:BitmapData = new BitmapData(58,62,true,color);
					var dest:Point = ISOCoordUtils.screenToGame(y,x);
					canvas.copyPixels(nodeBmd,nodeBmd.rect,dest);
				}
			}
			
			_numNodeX = Math.round(canvas.width / GRID_SIZE);
			_numNodeY = Math.round(canvas.height / GRID_SIZE);
			
			_nodeList = new Vector.<Vector.<Node>>(_numNodeX);
			for(x=0;x<_numNodeX;++x)
			{
				_nodeList[x] = new Vector.<Node>(_numNodeY);
				for(y =0;y<_numNodeY;++y)
				{
					_nodeList[x][y] = new Node(x,y);
					var _x:uint = x * GRID_SIZE - GRID_SIZE * .5;
					var _y:uint = y * GRID_SIZE - GRID_SIZE * .5;
					_nodeList[x][y].type = canvas.getPixel(_x,_y);
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
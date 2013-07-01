package components.map.data
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	import components.map.wayfinding.astar.Node;
	
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
		
		private var stage:DisplayObjectContainer;
		
		public function GridTypeMapData(stage:DisplayObjectContainer)
		{
			this.stage = stage;
		}
		
		public function initialize(navData:Vector.<uint>,numNodeX:uint,numNodeY:uint):void
		{
			_numNodeX = numNodeX;
			_numNodeY = numNodeY;
			_nodeList = new Vector.<Vector.<Node>>(_numNodeX);
			var canvas:BitmapData = new BitmapData(numNodeX * GRID_SIZE , numNodeY * GRID_SIZE );
			for(var x:uint=0;x<numNodeX;++x)
			{
				_nodeList[x] = new Vector.<Node>(_numNodeY);
				for(var y:uint =0;y<numNodeY;++y)
				{
					_nodeList[x][y] = new Node(x,y);
					_nodeList[x][y].type = navData[y*numNodeY + x];
					var color:uint = _nodeList[x][y].type != 0 ? 0x7F000000 : 0x7f0000ff;
					var nodeBmd:BitmapData = new BitmapData(GRID_SIZE,GRID_SIZE,true,color);
					canvas.copyPixels(nodeBmd,nodeBmd.rect,new Point(x*GRID_SIZE,y*GRID_SIZE));
				}
			}
			stage.addChild(new Bitmap(canvas));
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
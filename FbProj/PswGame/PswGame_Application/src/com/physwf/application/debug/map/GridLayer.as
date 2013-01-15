package com.physwf.application.debug.map
{
	import com.physwf.components.map.data.GridTypeMapData;
	import com.physwf.components.map.wayfinding.astar.BiHeapAStar;
	import com.physwf.components.map.wayfinding.astar.IAstar;
	import com.physwf.components.map.wayfinding.astar.Node;
	import com.physwf.components.map.wayfinding.astar.NodeType;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	public class GridLayer extends Sprite
	{
		private var astar:IAstar ;
		private var gridSize:int = 10;
		private var bm:Bitmap
		
		public function GridLayer()
		{
			super();
		}
		
		public function initialize(doc:Sprite):void
		{
			var w:int = doc.width;
			var h:int = doc.height;
			var bmd:BitmapData = new BitmapData(w,h,true,0xFF000000);
			
			var gridBmd:BitmapData 
			var colors:Array = [NodeType.TYPE_LAND,NodeType.TYPE_WATER,NodeType.TYPE_ICE,NodeType.TYPE_GRASS];
			for(var x:int=0;x<w/gridSize;++x)
			{
				for(var y:int=0;y<h/gridSize;++y)
				{
					var color:uint = colors[int(4 * Math.random())]
					gridBmd = new BitmapData(10,10,true,color);
					bmd.copyPixels(gridBmd,gridBmd.rect,new Point(x*10,y*10));
				}
			}
			bm = addChild(new Bitmap(bmd)) as Bitmap;
			var mapData:GridTypeMapData = new GridTypeMapData();
			astar = new BiHeapAStar();
			//			astar = new QuickSortAstar();
			mapData.initialize(bm,new Rectangle(0,0,w,h),gridSize);
			//			astar.initialze(bm,new GridTypeConfig());
			astar.mapData = mapData;
			addEventListener(MouseEvent.CLICK,onClick);
		}
		
		private var startPoint:Point;
		private var endPoint:Point;
		private function onClick(e:MouseEvent):void
		{
			if(!startPoint)
			{
				startPoint = new Point(e.stageX,e.stageY);
				return;
			}
			else
			{
				endPoint = new Point(e.stageX,e.stageY);
			}
			var sx:int = startPoint.x / 10;
			var sy:int = startPoint.y / 10;
			var ex:int = endPoint.x / 10;
			var ey:int = endPoint.y / 10;
			var lastT:uint = getTimer();
			if(astar.tryFindPath(sx,sy,ex,ey))
			{
				trace(getTimer() - lastT)
				var path:Vector.<Node>= astar.getPath();
				for(var i:int =0 ;i<path.length;++i)
				{
					var bmd:BitmapData = new BitmapData(gridSize,gridSize,false,0xFFFF0000);
					bm.bitmapData.copyPixels(bmd,bmd.rect,new Point(path[i].x * gridSize,path[i].y * gridSize));
				}
			}
			else
			{
				trace("no path found!!");
			}
			startPoint = null;
		}
	}
}
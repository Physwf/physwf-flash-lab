package com.physwf.application.debug.map
{
	import com.physwf.components.map.wayfinding.astar.Node;
	
	import flash.display.Sprite;
	
	public class GridLayer extends Sprite
	{
		private var gridSize:uint;
		
		public function GridLayer()
		{
			super();
		}
		
		public function initialize(grid:Vector.<Vector.<Node>):void
		{
			for(var x:uint=0;x<grid.length;++x)
			{
				for(var y:uint =0;y<grid[x].length;++y)
				{
					var node:Node = grid[x][y] = new Node(x,y);
					var fillColor:uint;
					if(node.walkable)
					{
						fillColor = 0x00FF00;
					}
					else
					{
						fillColor = 0;
					}
					graphics.lineStyle(1,0,0.5);
					graphics.beginFill(fillColor,0.5);
					graphics.drawRect(node.x,node.y,gridSize,gridSize);
					graphics.endFill();
				}
			}
		}
	}
}
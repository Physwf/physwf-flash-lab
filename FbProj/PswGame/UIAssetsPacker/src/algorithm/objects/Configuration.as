package algorithm.objects
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Configuration
	{
		private var angles:Vector.<Point>;
		private var boarders:Vector.<Line>;
		
		public function Configuration()
		{
			angles = new Vector.<Point>();
			boarders = new Vector.<Line>();
		}
		/**
		 * 获取同rect右边界距离最近的边界，如果返回为空，则说明没有合适的矩形存在 
		 * @param rect
		 * @return 
		 */		
		public function getNearestBoarder(angle:Point):Line
		{
			var ret:Line;
			var minDist:Number = Number.MAX_VALUE;
			for(var j:int=0;j<boarders.length;++j)
			{
				if(angle.y>=boarders[j].bottom && angle.y<=boarders[j].top)
				{
					if(boarders[j].pos>angle.x)
					{
						var dist:Number = boarders[j].pos - angle.x;
						if(dist<minDist)
						{
							ret = boarders[j];
							minDist = dist;
						}
					}
				}
			}
			return ret;
		}
		
		public function addAngle(angle:Point):void
		{
			angles.push(angle);
		}
		
		public function addBoarder(boader:Line):void
		{
			if(boader.pos>0) 
			{
				boarders.push(boader);
			}
		}
		
		public function sort():void
		{
			angles.sort(function(A:Point,B:Point):Number
			{
				if(A.y < B.y)
				{
					return -1;
				}
				else if(A.y > B.y)
				{
					return 1;
				}
				else
				{
					if(A.x < B.x)
					{
						return -1;
					}
					else
					{
						return 1;
					}
					return 0;
				}
			});
		}
		
		public function popAngle():Point
		{
			return angles.shift();
		}
	}
}
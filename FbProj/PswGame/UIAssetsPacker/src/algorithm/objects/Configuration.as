package algorithm.objects
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Configuration
	{
		private var angles:Vector.<Point>;
		private var boaders:Vector.<Line>;
		
		public function Configuration()
		{
			angles = new Vector.<Point>();
			boaders = new Vector.<Line>();
		}
		/**
		 * 获取同rect右边界距离最近的边界，如果返回为空，则说明没有合适的矩形存在 
		 * @param rect
		 * @return 
		 */		
		public function getNearestBoarder(rect:Rectangle):Line
		{
			var ret:Line;
			var minDist:Number = Number.MAX_VALUE;
			for(var i:int=0;i<boaders.length;++i)
			{
				if(rect.y >= boaders[i].bottom && rect.y <= boaders[i].top)//该矩形底边同边界相交
				{
					if(rect.x + rect.width > boaders[i].pos)
					{
						continue;
					}
					else
					{
						minDist = (boaders[i].pos - (rect.x + rect.width));
						ret = boaders[i];
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
			boaders.push(boader);
		}
		
		public function sort():void
		{
			angles.sort(function(A:Point,B:Point):Number
			{
				if(A.y < B.y)
				{
					if(A.x < B.x)
					{
						return 1;
					}
					return -1;
				}
				else if(A.y > B.y)
				{
					return 1;
				}
				else
				{
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
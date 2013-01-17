package com.physwf.components.map.wayfinding.astar
{
	public class PathUtils
	{
		public function PathUtils()
		{
		}
		/**
		 * 计算路径的平均方向 
		 * @param path 路径
		 * @param numNode 路径节点取样个数
		 * @return 弧度
		 * 
		 */		
		public static function calAverDirec(path:Vector.<Node>,numNode:uint=5):Number
		{
			var start:Node = path[0];
			var angle:Number =0;
			numNode = path.length>=numNode?numNode:path.length;
			for(var i:int=1;i<numNode;++i)
			{
				angle += Math.atan2(path[i].y - start.y , path[i].x - start.x);
			}
			return angle/(numNode-1);
		}
		
		public static function calAverDirec2(pathLine:Vector.<Line>,numNode:uint=15):Number
		{
			var start:Line = pathLine[0];
			var angle:Number =0;
			numNode = pathLine.length>=numNode?numNode:pathLine.length;
			for(var i:int=1;i<numNode;++i)
			{
				angle += Math.atan2(pathLine[i].ey - start.sy , pathLine[i].ex - start.sx);
			}
			return angle/(numNode-1);
		}
	}
}
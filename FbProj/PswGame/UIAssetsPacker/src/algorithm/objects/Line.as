package algorithm.objects
{
	import flash.geom.Point;
	/**
	 * 按屏幕坐标，bottom在位于top之上 
	 * @author joe
	 * 
	 */
	public class Line
	{
		public var bottom:Number;
		public var top:Number;
		public var pos:Number; //x方向坐标
		
		public function Line(b:Number,t:Number,p:Number)
		{
			bottom = b;
			top = t;
			pos = p;
		}
	}
}
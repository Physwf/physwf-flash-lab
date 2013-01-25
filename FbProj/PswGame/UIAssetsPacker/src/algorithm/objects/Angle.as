package algorithm.objects
{
	import flash.geom.Point;

	public class Angle
	{
		public var pos:Point;
		public var boarder:Line;
		
		public function Angle(p:Point,boarderH:Number)
		{
			pos = p;
			boarder = new Line(pos.y,pos.y+boarderH,pos.x,null);
		}
	}
}
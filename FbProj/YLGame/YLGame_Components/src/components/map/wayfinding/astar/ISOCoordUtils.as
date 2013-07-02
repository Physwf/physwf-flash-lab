package components.map.wayfinding.astar
{
	import flash.geom.Point;

	public class ISOCoordUtils
	{
		public static var offsetX:int;
		public static var offsetY:int;
		public static var size:uint;
		public static var angle:uint;
		
		public function ISOCoordUtils()
		{
		}
		
		public static function gameToScreen(x:Number,y:Number):Point
		{
			x -= offsetX;
			y -= offsetY;
			var radian:Number = angle * Math.PI / 180;
			var twoTimesCosAngle:Number = Math.cos(radian) * 2;
			var twoTimesSinAngle:Number = Math.sin(radian) * 2;
			return new Point(
				int((y / twoTimesCosAngle + x / twoTimesSinAngle) / size),
				int((y / twoTimesCosAngle - x / twoTimesSinAngle) / size)
			);
		}
		
		public static function screenToGame(x:uint,y:uint):Point
		{
			var radian:Number = angle * Math.PI / 180;
			return new Point(
				(x - y) * Math.sin(radian) * size + offsetX,
				(x + y) * Math.cos(radian) * size + offsetY
			);
		}
	}
}
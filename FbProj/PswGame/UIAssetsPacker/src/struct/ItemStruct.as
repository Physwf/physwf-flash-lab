package struct
{
	import flash.display.BitmapData;
	import flash.geom.Point;

	public class ItemStruct
	{
		public static var ID:uint = 0;
		public var position:Point;
		public var obj:BitmapData;
		public var id:uint;
		
		public function ItemStruct(pos:Point,o:BitmapData)
		{
			position = pos;
			obj = o;
			id = ID++;
		}
	}
}
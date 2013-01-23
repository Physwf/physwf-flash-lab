package struct
{
	import flash.display.BitmapData;
	import flash.geom.Point;

	public class ItemStruct
	{
		public var position:Point;
		public var obj:BitmapData;
		
		public function ItemStruct(pos:Point,o:BitmapData)
		{
			position = pos;
			obj = o;
		}
	}
}
package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class AssetsFactory
	{
		[Embed(source="../assets/tiles.png")]
		private static var tile:Class;
		
		private static var data:BitmapData;
		
		public function AssetsFactory()
		{
		}
		
		public static function getBitmapData():BitmapData
		{
			if(!data) data = ((new tile) as Bitmap).bitmapData;
			return data
		}
	}
	
	
}
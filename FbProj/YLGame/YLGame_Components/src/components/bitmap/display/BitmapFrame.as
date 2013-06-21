package components.bitmap.display
{
	import flash.display.BitmapData;

	/**
	 * 动作帧
	 * @author yuelei.qiao
	 * 
	 */	
	public class BitmapFrame
	{
		
		public static const emptyBmd:BitmapData = new BitmapData(1,1,true,0x0000);
		
		public var x:int;
		public var y:int;
		public var bitmapData:BitmapData;
		
		public function BitmapFrame()
		{
			bitmapData = emptyBmd;
		}
	}
}
package components.utils
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	public interface IDecoder
	{
		function get bitmap():BitmapData;
		function decode(data:ByteArray):BitmapData;
	}
}


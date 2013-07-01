package components.utils
{
	import flash.utils.ByteArray;

	public class ByteHelper
	{
		public function ByteHelper()
		{
		}
		
		public static function readString(data:ByteArray):String
		{
			var count:uint = 0;
			for(var i:uint = data.position;i<data.length;++i) {
				var value:uint = data[i];
				count += 1;
				if (value == 0) break;
			}
			return data.readUTFBytes(count);
		}
	}
}
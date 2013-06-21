package components.utils
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class ImageUtils
	{
		public function ImageUtils()
		{
		}
		
		public static function isPNG(data:ByteArray):Boolean
		{
			data.position = 0;
			data.endian = Endian.BIG_ENDIAN;
			var head0:uint = data.readUnsignedInt();
			var head1:uint = data.readUnsignedInt();
			if(head0 == 0x89504E47 && head1 == 0x0D0A1A0A) 
			{
				data.position = 0;
				return true;
			}
			data.position = 0;
			return false;
		}
	}
}
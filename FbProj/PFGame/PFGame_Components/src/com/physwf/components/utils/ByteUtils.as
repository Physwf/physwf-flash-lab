package com.physwf.components.utils
{
	import flash.utils.ByteArray;

	public class ByteUtils
	{
		public function ByteUtils()
		{
		}
		
		/**
		 * 将字节数组对象按字节顺序打印。 
		 * @param bytes 被打印的字节数组对象
		 * @param system 进制
		 * @param segmentLen 每个片段的字节长度，片段与片段之间用空白字符分割
		 * 
		 */
		public static function printf(bytes:ByteArray,system:uint = 16,segmentLen:uint = 1):void
		{
			var pos:uint = bytes.position;
			bytes.position = 0;
			var step:uint=0;
			var s:String = "";
			var n:String;
			while(bytes.bytesAvailable)
			{
				if(step%segmentLen==0 && step!=0) s += " ";
				n = bytes.readUnsignedByte().toString(system);
				if(n.length==1) n = "0" + n;
				s += n;
				step++;
			}
			trace(s);
			bytes.position = pos;
		}
	}
}
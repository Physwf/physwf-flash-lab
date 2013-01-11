package com.physwf.components.bitmap.data
{
	import com.physwf.components.bitmap.net.BitmapDataPackageLoader;
	
	import flash.sampler.getSize;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	

	public class BigKey
	{
		public var endian:int = BitmapDataPackageLoader.BIG_KEY_ENDIAN;
		public var directions:Vector.<String> = new <String>[];
		public var smallKeys:Array = [];
		
		public function readKey(input:IDataInput):void
		{
			input.readShort();
			var directionsLen:uint = input.readShort();
			directions = Vector.<String>(input.readUTFBytes(directionsLen).split(","));
			var len:int = input.readShort();
			var tempByte:ByteArray;
			for(var i:int =0;i<len;++i)
			{
				var size:int = input.readShort();
				tempByte = new ByteArray();
				input.readBytes(tempByte,0,size);
				smallKeys[i]= tempByte;
			}
		}
		
		public function writeKey(output:IDataOutput):void
		{
			output.writeShort(endian);
			var directionisData:ByteArray = new ByteArray();
			directionisData.writeUTFBytes(directions.join());
			var directionLen:uint = directionisData.length;
			output.writeShort(directionLen);
			output.writeBytes(directionisData);
			
			output.writeShort(smallKeys.length);
			for(var i:int =0;i<smallKeys.length;++i)
			{
				var size:int = getSize(smallKeys[i]);
				output.writeShort(size);
				output.writeBytes(smallKeys[i]);
			}
		}
	}
}
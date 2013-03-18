package file
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import struct.Record;

	public class ClientFile implements IClientFile
	{
		public var records:Vector.<Record>;
		
		private var fileSavePath:String;
		
		public function ClientFile(path:String)
		{
			fileSavePath = path;
		}
		
		public function readExcel(sheet:Array):void
		{
			throw "To be override by subclass!";
		}
		
		public function write(name:String,struct:String):void
		{
			var f:File = new File(fileSavePath);
			var fs:FileStream = new FileStream();
			fs.open(f,FileMode.WRITE);
			
			var nameData:ByteArray = new ByteArray();
			nameData.writeUTFBytes(name);
			fs.writeShort(nameData.length);
			fs.writeBytes(nameData);
			
			var structData:ByteArray = new ByteArray();
			structData.writeUTFBytes(struct);
			fs.writeShort(structData.length);
			fs.writeBytes(structData);
			
			for(var i:uint=0;i<records.length;++i)
			{
				fs.writeUnsignedInt(records[i].key);
				fs.writeUnsignedInt(records[i].len);
				fs.writeBytes(records[i].data);
			}
			fs.close();
		}
	}
}
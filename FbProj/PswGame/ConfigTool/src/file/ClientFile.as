package file
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
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
		
		public function write():void
		{
			var f:File = new File(fileSavePath);
			var fs:FileStream = new FileStream();
			fs.open(f,FileMode.WRITE);
			
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
package file
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import struct.Record;
	import com.physwf.config.struct.cfg_map;

	public class MapFile extends ClientFile
	{
		public function MapFile(path:String)
		{
			super(path);
		}
		
		override public function readExcel(sheet:Array):void
		{
			var row:uint = sheet.length;
			var column:uint = sheet[0].length;
			
			records = new Vector.<Record>();
			
			for(var i:uint=4;i<row;++i)
			{
				var mapS:cfg_map = new cfg_map();
				for(var j:uint=0;j<column;++j)
				{
					mapS[sheet[1][j]] = sheet[i][j];
				}
				var recordData:ByteArray = new ByteArray();
				mapS.writeExternal(recordData);
				
				var record:Record = new Record();
				record.key = mapS.map_id;
				record.len = recordData.length;
				record.data = recordData;
				records.push(record);
			}
		}
	}
}
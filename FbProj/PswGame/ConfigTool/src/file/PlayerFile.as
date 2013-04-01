package file
{
	import com.physwf.config.struct.cfg_player;
	
	import flash.utils.ByteArray;
	
	import struct.Record;

	public class PlayerFile extends ClientFile
	{
		public function PlayerFile(path:String)
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
				var npcP:cfg_player = new cfg_player();
				for(var j:uint=0;j<column;++j)
				{
					npcP[sheet[1][j]] = sheet[i][j];
				}
				var recordData:ByteArray = new ByteArray();
				npcP.writeExternal(recordData);
				
				var record:Record = new Record();
				record.key = npcP.num;
				record.len = recordData.length;
				record.data = recordData;
				records.push(record);
			}
		}
	}
}
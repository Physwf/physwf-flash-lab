package file
{
	import flash.utils.ByteArray;
	
	import struct.Record;
	import struct.cfg_monster;

	public class MonsterFile extends ClientFile
	{
		public function MonsterFile(path:String)
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
				var monS:cfg_monster = new cfg_monster();
				for(var j:uint=0;j<column;++j)
				{
					monS[sheet[1][j]] = sheet[i][j];
				}
				var recordData:ByteArray = new ByteArray();
				monS.writeExternal(recordData);
				
				var record:Record = new Record();
				record.key = monS.monster_id;
				record.len = recordData.length;
				record.data = recordData;
				records.push(record);
			}
		}
	}
}
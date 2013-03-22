package file
{
	import flash.utils.ByteArray;
	
	import struct.Record;
	import com.physwf.config.struct.cfg_npc;

	public class NPCFile extends ClientFile
	{
		public function NPCFile(path:String)
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
				var npcS:cfg_npc = new cfg_npc();
				for(var j:uint=0;j<column;++j)
				{
					npcS[sheet[1][j]] = sheet[i][j];
				}
				var recordData:ByteArray = new ByteArray();
				npcS.writeExternal(recordData);
				
				var record:Record = new Record();
				record.key = npcS.npc_id;
				record.len = recordData.length;
				record.data = recordData;
				records.push(record);
			}
		}
	}
}
package file
{
	import flash.utils.ByteArray;
	
	import struct.Record;
	import struct.cfg_effect;

	public class EffectFile extends ClientFile
	{
		public function EffectFile(path:String)
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
				var effS:cfg_effect = new cfg_effect();
				for(var j:uint=0;j<column;++j)
				{
					effS[sheet[1][j]] = sheet[i][j];
				}
				var recordData:ByteArray = new ByteArray();
				effS.writeExternal(recordData);
				
				var record:Record = new Record();
				record.key = effS.id;
				record.len = recordData.length;
				record.data = recordData;
				records.push(record);
			}
		}
		
	}
}
package file
{
	import com.physwf.config.struct.cfg_skill;
	
	import flash.utils.ByteArray;
	
	import struct.Record;

	public class SkillFile extends ClientFile
	{
		public function SkillFile(path:String)
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
				var monS:cfg_skill = new cfg_skill();
				for(var j:uint=0;j<column;++j)
				{
					monS[sheet[1][j]] = sheet[i][j];
				}
				var recordData:ByteArray = new ByteArray();
				monS.writeExternal(recordData);
				
				var record:Record = new Record();
				record.key = monS.skill_id;
				record.len = recordData.length;
				record.data = recordData;
				records.push(record);
			}
		}
	}
}
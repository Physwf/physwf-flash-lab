package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_task_t implements IExternalizable
	{
		public var quest:Vector.<xml_task_quest_t>;
		
		public function xml_task_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var questLen:uint =input.readUnsignedInt();
			quest= new Vector.<xml_task_quest_t>();
			for(var i:int=0;i<questLen;++i)
			{
				var quest_item:xml_task_quest_t = new xml_task_quest_t()
				quest_item.readExternal(input);;
				quest.push(quest_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(quest.length);
			for(var j:int=0;j<quest.length;++j)
			{
				quest[j].writeExternal(output);
			}			
		}
	}
}
package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_task_quest_t implements IExternalizable
	{
		public var task_id:uint;
		public var type:uint;
		public var pre:Vector.<uint>;
		public var isand:uint;
		public var need_level:uint;
		public var bind_map_id:uint;
		public var prize_id:uint;
		public var complete_recover:Vector.<uint>;
		public var step:Vector.<xml_task_quest_step_t>;
		
		public function xml_task_quest_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			task_id = input.readUnsignedShort();
			type = input.readUnsignedByte();
			var preLen:uint =input.readUnsignedInt();
			pre= new Vector.<uint>();
			for(var i:int=0;i<preLen;++i)
			{
				var pre_item:uint = input.readUnsignedShort();;
				pre.push(pre_item);
			}
			isand = input.readUnsignedByte();
			need_level = input.readUnsignedShort();
			bind_map_id = input.readUnsignedInt();
			prize_id = input.readUnsignedShort();
			var complete_recoverLen:uint =input.readUnsignedInt();
			complete_recover= new Vector.<uint>();
			for(var k:int=0;k<complete_recoverLen;++k)
			{
				var complete_recover_item:uint = input.readUnsignedInt();;
				complete_recover.push(complete_recover_item);
			}
			var stepLen:uint =input.readUnsignedInt();
			step= new Vector.<xml_task_quest_step_t>();
			for(var q:int=0;q<stepLen;++q)
			{
				var step_item:xml_task_quest_step_t = new xml_task_quest_step_t()
				step_item.readExternal(input);;
				step.push(step_item);
			}			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(task_id);
			output.writeByte(type);
			output.writeUnsignedInt(pre.length);
			for(var j:int=0;j<pre.length;++j)
			{
				output.writeShort(pre[j]);
			}
			output.writeByte(isand);
			output.writeShort(need_level);
			output.writeUnsignedInt(bind_map_id);
			output.writeShort(prize_id);
			output.writeUnsignedInt(complete_recover.length);
			for(var p:int=0;p<complete_recover.length;++p)
			{
				output.writeUnsignedInt(complete_recover[p]);
			}
			output.writeUnsignedInt(step.length);
			for(var r:int=0;r<step.length;++r)
			{
				step[r].writeExternal(output);
			}			
		}
	}
}
package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_task_t implements IExternalizable
	{
		public var task_id:uint;
		public var step_id:uint;
		public var rate:uint;
		public var expire_time:uint;
		public var day_cnt:uint;
		
		public function db_task_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			task_id = input.readUnsignedInt();
			step_id = input.readUnsignedShort();
			rate = input.readUnsignedShort();
			expire_time = input.readUnsignedInt();
			day_cnt = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(task_id);
			output.writeShort(step_id);
			output.writeShort(rate);
			output.writeUnsignedInt(expire_time);
			output.writeShort(day_cnt);			
		}
	}
}
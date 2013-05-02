package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_event_t implements IExternalizable
	{
		public var event_id:uint;
		public var event_type:uint;
		public var event_add_time:uint;
		public var data1:uint;
		public var data2:uint;
		
		public function db_event_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			event_id = input.readUnsignedInt();
			event_type = input.readUnsignedInt();
			event_add_time = input.readUnsignedInt();
			data1 = input.readUnsignedInt();
			data2 = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(event_id);
			output.writeUnsignedInt(event_type);
			output.writeUnsignedInt(event_add_time);
			output.writeUnsignedInt(data1);
			output.writeUnsignedInt(data2);			
		}
	}
}
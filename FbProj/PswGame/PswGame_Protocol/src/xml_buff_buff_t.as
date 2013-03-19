package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_buff_buff_t implements IExternalizable
	{
		public var buff_id:uint;
		public var buff_type:uint;
		public var buff_finish_type:uint;
		public var duration_time:uint;
		public var buff_repeat:uint;
		public var max_trigger_times:uint;
		public var dead_delete:uint;
		public var aura_radius:uint;
		public var inflect_id:uint;
		public var sys_time:uint;
		public var out_time:uint;
		
		public function xml_buff_buff_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			buff_id = input.readUnsignedShort();
			buff_type = input.readUnsignedShort();
			buff_finish_type = input.readUnsignedShort();
			duration_time = input.readUnsignedShort();
			buff_repeat = input.readUnsignedShort();
			max_trigger_times = input.readUnsignedShort();
			dead_delete = input.readUnsignedShort();
			aura_radius = input.readUnsignedShort();
			inflect_id = input.readUnsignedShort();
			sys_time = input.readUnsignedInt();
			out_time = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(buff_id);
			output.writeShort(buff_type);
			output.writeShort(buff_finish_type);
			output.writeShort(duration_time);
			output.writeShort(buff_repeat);
			output.writeShort(max_trigger_times);
			output.writeShort(dead_delete);
			output.writeShort(aura_radius);
			output.writeShort(inflect_id);
			output.writeUnsignedInt(sys_time);
			output.writeShort(out_time);			
		}
	}
}
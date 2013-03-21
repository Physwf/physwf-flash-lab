package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_buff_buff_t implements IExternalizable
	{
		public var buff_id:uint;
		public var buff_sub_type:uint;
		public var clear:uint;
		public var immune:uint;
		public var trigger_type:uint;
		public var trigger_time:uint;
		public var trigger_rate:uint;
		public var trigger_value:uint;
		public var trigger_percent:uint;
		public var duration:uint;
		public var repeat:uint;
		public var dead_delete:uint;
		public var radius:uint;
		public var sys_time:uint;
		public var out_time:uint;
		
		public function xml_buff_buff_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			buff_id = input.readUnsignedShort();
			buff_sub_type = input.readUnsignedShort();
			clear = input.readUnsignedByte();
			immune = input.readUnsignedByte();
			trigger_type = input.readUnsignedShort();
			trigger_time = input.readUnsignedShort();
			trigger_rate = input.readUnsignedShort();
			trigger_value = input.readUnsignedShort();
			trigger_percent = input.readUnsignedShort();
			duration = input.readUnsignedInt();
			repeat = input.readUnsignedShort();
			dead_delete = input.readUnsignedShort();
			radius = input.readUnsignedShort();
			sys_time = input.readUnsignedInt();
			out_time = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(buff_id);
			output.writeShort(buff_sub_type);
			output.writeByte(clear);
			output.writeByte(immune);
			output.writeShort(trigger_type);
			output.writeShort(trigger_time);
			output.writeShort(trigger_rate);
			output.writeShort(trigger_value);
			output.writeShort(trigger_percent);
			output.writeUnsignedInt(duration);
			output.writeShort(repeat);
			output.writeShort(dead_delete);
			output.writeShort(radius);
			output.writeUnsignedInt(sys_time);
			output.writeShort(out_time);			
		}
	}
}
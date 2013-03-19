package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_effect_effect_t implements IExternalizable
	{
		public var inflect_id:uint;
		public var inflect_type:uint;
		public var trigger_type:uint;
		public var trigger_time:uint;
		public var trigger_rate:uint;
		public var trigger_value:uint;
		public var trigger_percent:uint;
		
		public function xml_effect_effect_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			inflect_id = input.readUnsignedShort();
			inflect_type = input.readUnsignedShort();
			trigger_type = input.readUnsignedShort();
			trigger_time = input.readUnsignedShort();
			trigger_rate = input.readUnsignedShort();
			trigger_value = input.readUnsignedShort();
			trigger_percent = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(inflect_id);
			output.writeShort(inflect_type);
			output.writeShort(trigger_type);
			output.writeShort(trigger_time);
			output.writeShort(trigger_rate);
			output.writeShort(trigger_value);
			output.writeShort(trigger_percent);			
		}
	}
}
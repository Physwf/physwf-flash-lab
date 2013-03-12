package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class item_enclosure_t implements IExternalizable
	{
		public var item_id:uint;
		public var item_count:uint;
		public var end_time:uint;
		
		public function item_enclosure_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			item_id = input.readUnsignedInt();
			item_count = input.readUnsignedInt();
			end_time = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(item_id);
			output.writeUnsignedInt(item_count);
			output.writeUnsignedInt(end_time);			
		}
	}
}
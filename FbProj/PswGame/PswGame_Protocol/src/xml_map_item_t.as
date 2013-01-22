package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_map_item_t implements IExternalizable
	{
		public var map_id:uint;
		
		public function xml_map_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			map_id = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(map_id);			
		}
	}
}
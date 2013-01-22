package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_maps_item_t implements IExternalizable
	{
		public var MapId:uint;
		
		public function xml_maps_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			MapId = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(MapId);			
		}
	}
}
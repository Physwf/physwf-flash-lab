package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_drop_drop_group_item_t implements IExternalizable
	{
		public var item_id:uint;
		public var item_cnt:uint;
		
		public function xml_drop_drop_group_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			item_id = input.readUnsignedInt();
			item_cnt = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(item_id);
			output.writeUnsignedInt(item_cnt);			
		}
	}
}
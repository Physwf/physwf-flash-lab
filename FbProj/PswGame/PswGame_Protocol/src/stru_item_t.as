package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_item_t implements IExternalizable
	{
		public var itemid:uint;
		public var itemcnt:uint;
		
		public function stru_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			itemid = input.readUnsignedInt();
			itemcnt = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(itemid);
			output.writeInt(itemcnt);			
		}
	}
}
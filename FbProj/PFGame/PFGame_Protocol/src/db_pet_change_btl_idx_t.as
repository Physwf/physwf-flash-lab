package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_pet_change_btl_idx_t implements IExternalizable
	{
		public var key:uint;
		public var btl_index:uint;
		
		public function db_pet_change_btl_idx_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			key = input.readUnsignedInt();
			btl_index = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(key);
			output.writeUnsignedInt(btl_index);			
		}
	}
}
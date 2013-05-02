package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_pet_equipment_addition_t implements IExternalizable
	{
		public var key:uint;
		public var val:uint;
		
		public function db_pet_equipment_addition_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			key = input.readUnsignedShort();
			val = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(key);
			output.writeUnsignedInt(val);			
		}
	}
}
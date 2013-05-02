package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_add_del_pet_equipment_t implements IExternalizable
	{
		public var id:uint;
		public var pos:uint;
		public var pet_key:uint;
		
		public function db_add_del_pet_equipment_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			pos = input.readUnsignedInt();
			pet_key = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(id);
			output.writeUnsignedInt(pos);
			output.writeUnsignedInt(pet_key);			
		}
	}
}
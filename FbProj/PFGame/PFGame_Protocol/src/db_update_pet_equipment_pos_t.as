package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_update_pet_equipment_pos_t implements IExternalizable
	{
		public var id:uint;
		public var src_pos:uint;
		public var src_pet_key:uint;
		public var des_pos:uint;
		public var des_pet_key:uint;
		
		public function db_update_pet_equipment_pos_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			src_pos = input.readUnsignedInt();
			src_pet_key = input.readUnsignedInt();
			des_pos = input.readUnsignedInt();
			des_pet_key = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(id);
			output.writeUnsignedInt(src_pos);
			output.writeUnsignedInt(src_pet_key);
			output.writeUnsignedInt(des_pos);
			output.writeUnsignedInt(des_pet_key);			
		}
	}
}
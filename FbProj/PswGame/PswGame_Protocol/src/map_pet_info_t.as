package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class map_pet_info_t implements IExternalizable
	{
		public var pet_no:uint;
		public var pet_id:uint;
		public var pet_level:uint;
		public var pet_star:uint;
		
		public function map_pet_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			pet_no = input.readUnsignedInt();
			pet_id = input.readUnsignedInt();
			pet_level = input.readUnsignedInt();
			pet_star = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(pet_no);
			output.writeUnsignedInt(pet_id);
			output.writeUnsignedInt(pet_level);
			output.writeUnsignedInt(pet_star);			
		}
	}
}
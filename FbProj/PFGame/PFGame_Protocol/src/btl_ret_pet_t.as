package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class btl_ret_pet_t implements IExternalizable
	{
		public var pet_key:uint;
		public var add_exp:uint;
		
		public function btl_ret_pet_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			pet_key = input.readUnsignedInt();
			add_exp = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(pet_key);
			output.writeUnsignedInt(add_exp);			
		}
	}
}
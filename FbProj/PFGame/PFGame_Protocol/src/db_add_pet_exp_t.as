package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_add_pet_exp_t implements IExternalizable
	{
		public var key:uint;
		public var exp:uint;
		public var def_skill_exp:uint;
		
		public function db_add_pet_exp_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			key = input.readUnsignedInt();
			exp = input.readUnsignedInt();
			def_skill_exp = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(key);
			output.writeUnsignedInt(exp);
			output.writeUnsignedInt(def_skill_exp);			
		}
	}
}
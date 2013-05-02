package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_user_skill_t implements IExternalizable
	{
		public var id:uint;
		public var exp:uint;
		public var flag:uint;
		
		public function db_user_skill_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			exp = input.readUnsignedInt();
			flag = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(id);
			output.writeUnsignedInt(exp);
			output.writeByte(flag);			
		}
	}
}
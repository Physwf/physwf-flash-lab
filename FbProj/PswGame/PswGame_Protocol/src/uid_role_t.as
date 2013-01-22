package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class uid_role_t implements IExternalizable
	{
		public var user_id:uint;
		public var role_tm:uint;
		
		public function uid_role_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			user_id = input.readUnsignedInt();
			role_tm = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(user_id);
			output.writeUnsignedInt(role_tm);			
		}
	}
}
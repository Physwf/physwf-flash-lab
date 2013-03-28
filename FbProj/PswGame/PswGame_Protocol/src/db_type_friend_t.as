package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_type_friend_t implements IExternalizable
	{
		public var type:uint;
		public var user_id:uint;
		public var role_tm:uint;
		public var add_time:uint;
		
		public function db_type_friend_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			type = input.readUnsignedShort();
			user_id = input.readUnsignedInt();
			role_tm = input.readUnsignedInt();
			add_time = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(type);
			output.writeUnsignedInt(user_id);
			output.writeUnsignedInt(role_tm);
			output.writeUnsignedInt(add_time);			
		}
	}
}
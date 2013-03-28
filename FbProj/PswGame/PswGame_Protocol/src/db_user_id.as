package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_user_id implements IExternalizable
	{
		public var user_id:uint;
		public var area_id:uint;
		public var role_tm:uint;
		
		public function db_user_id()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			user_id = input.readUnsignedInt();
			area_id = input.readUnsignedShort();
			role_tm = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(user_id);
			output.writeShort(area_id);
			output.writeUnsignedInt(role_tm);			
		}
	}
}
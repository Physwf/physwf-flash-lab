package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class base_user_info_t implements IExternalizable
	{
		public var uid:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var world_id:uint;
		
		public function base_user_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			uid = input.readUnsignedInt();
			nick = input.readUTF();
			world_id = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);
			output.writeUTF(nick);
			output.writeShort(world_id);			
		}
	}
}
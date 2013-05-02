package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class add_friend_offline_msg_t implements IExternalizable
	{
		public var sn:uint;
		public var uid:uint;
		public var nick:String;
		public var nick_data:ByteArray
		
		public function add_friend_offline_msg_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			sn = input.readUnsignedInt();
			uid = input.readUnsignedInt();
			nick = input.readUTF();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(sn);
			output.writeUnsignedInt(uid);
			output.writeUTF(nick);			
		}
	}
}
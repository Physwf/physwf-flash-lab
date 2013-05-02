package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_CHAT_PRIVATE_0x1304 extends MsgBase
	{
		public var uid:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var msg:String;
		public var msg_data:ByteArray
		
		public function MSG_REQ_WORLD_USER_CHAT_PRIVATE_0x1304()
		{
			super(0x1304)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);
			output.writeUTF(nick);
			output.writeUTF(msg);			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_CHAT_PRIVATE_MSG_1017 extends MsgBase
	{
		public var msg_time:uint;
		public var sender:uid_role_t;
		public var sender_nick:String;
		public var receiver:uid_role_t;
		public var msg_content:String;
		
		public function MSG_RES_CHAT_PRIVATE_MSG_1017(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			msg_time = input.readUnsignedInt();
			sender= new uid_role_t();
			sender.readExternal(input)
			sender_nick = input.readUTFBytes(32);
			receiver= new uid_role_t();
			receiver.readExternal(input)
			var msg_contentLen:uint =input.readUnsignedInt();
			msg_content=input.readUTFBytes(msg_contentLen);			
		}
	}
}
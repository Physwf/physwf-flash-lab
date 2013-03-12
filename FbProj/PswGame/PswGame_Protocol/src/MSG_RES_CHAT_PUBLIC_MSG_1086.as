package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_CHAT_PUBLIC_MSG_1086 extends MsgBase
	{
		public var type:uint;
		public var sender:uid_role_t;
		public var sender_nick:String;
		public var sender_nick_data:ByteArray
		public var msg_content:String;
		public var msg_content_data:ByteArray
		
		public function MSG_RES_CHAT_PUBLIC_MSG_1086(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			type = input.readUnsignedByte();
			sender= new uid_role_t();
			sender.readExternal(input)
			sender_nick = input.readUTFBytes(16);
			var msg_contentLen:uint =input.readUnsignedInt();
			msg_content=input.readUTFBytes(msg_contentLen);			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_CHAT_PRIVATE_MSG_1085 extends MsgBase
	{
		public var receiver:uid_role_t;
		public var msg_content:String;
		public var msg_content_data:ByteArray
		
		public function MSG_REQ_CHAT_PRIVATE_MSG_1085()
		{
			super(1085)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			receiver.writeExternal(output)
			output.writeUnsignedInt(msg_content.length);
			output.writeUTFBytes(msg_content);			
		}
	}
}
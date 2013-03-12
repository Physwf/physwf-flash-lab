package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_CHAT_PUBLIC_MSG_1086 extends MsgBase
	{
		public var type:uint;
		public var msg_content:String;
		public var msg_content_data:ByteArray
		
		public function MSG_REQ_CHAT_PUBLIC_MSG_1086()
		{
			super(1086)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeByte(type);
			output.writeUnsignedInt(msg_content.length);
			output.writeUTFBytes(msg_content);			
		}
	}
}
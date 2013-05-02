package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_SMALL_CHAT_ALL_WORLD_0x1300 extends MsgBase
	{
		public var uid:uint;
		public var msg:String;
		public var msg_data:ByteArray
		
		public function MSG_REQ_WORLD_USER_SMALL_CHAT_ALL_WORLD_0x1300()
		{
			super(0x1300)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);
			output.writeUTF(msg);			
		}
	}
}
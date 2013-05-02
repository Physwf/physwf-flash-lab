package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_CHAT_MAP_0x1303 extends MsgBase
	{
		public var uid:uint;
		public var msg:String;
		public var msg_data:ByteArray
		
		public function MSG_REQ_WORLD_USER_CHAT_MAP_0x1303()
		{
			super(0x1303)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);
			output.writeUTF(msg);			
		}
	}
}
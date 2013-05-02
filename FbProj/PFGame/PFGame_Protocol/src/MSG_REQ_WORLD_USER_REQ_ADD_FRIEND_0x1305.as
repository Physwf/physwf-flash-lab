package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_REQ_ADD_FRIEND_0x1305 extends MsgBase
	{
		public var uid:uint;
		public var msg:db_msg_t;
		
		public function MSG_REQ_WORLD_USER_REQ_ADD_FRIEND_0x1305()
		{
			super(0x1305)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);
			msg.writeExternal(output)			
		}
	}
}
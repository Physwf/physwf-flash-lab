package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_ADD_FRIEND_OFFLINE_MSG_0x1309 extends MsgBase
	{
		public var sn:uint;
		public var uid:uint;
		public var agree:uint;
		
		public function MSG_REQ_WORLD_USER_ADD_FRIEND_OFFLINE_MSG_0x1309()
		{
			super(0x1309)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(sn);
			output.writeUnsignedInt(uid);
			output.writeByte(agree);			
		}
	}
}
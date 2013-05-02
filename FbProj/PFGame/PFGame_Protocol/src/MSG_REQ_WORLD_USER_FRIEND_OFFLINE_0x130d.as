package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_FRIEND_OFFLINE_0x130d extends MsgBase
	{
		public var uid:uint;
		
		public function MSG_REQ_WORLD_USER_FRIEND_OFFLINE_0x130d()
		{
			super(0x130d)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);			
		}
	}
}
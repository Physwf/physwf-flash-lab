package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_REQ_FRIEND_COMPLEX_INFO_0x1308 extends MsgBase
	{
		public var uid:uint;
		
		public function MSG_REQ_WORLD_USER_REQ_FRIEND_COMPLEX_INFO_0x1308()
		{
			super(0x1308)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);			
		}
	}
}
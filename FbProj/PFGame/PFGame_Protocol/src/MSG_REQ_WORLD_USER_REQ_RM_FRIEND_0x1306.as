package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_REQ_RM_FRIEND_0x1306 extends MsgBase
	{
		public var uid:uint;
		
		public function MSG_REQ_WORLD_USER_REQ_RM_FRIEND_0x1306()
		{
			super(0x1306)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);			
		}
	}
}
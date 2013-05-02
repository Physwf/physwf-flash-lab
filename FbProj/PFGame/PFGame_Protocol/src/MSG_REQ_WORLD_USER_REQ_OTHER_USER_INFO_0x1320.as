package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_REQ_OTHER_USER_INFO_0x1320 extends MsgBase
	{
		public var uid:uint;
		
		public function MSG_REQ_WORLD_USER_REQ_OTHER_USER_INFO_0x1320()
		{
			super(0x1320)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);			
		}
	}
}
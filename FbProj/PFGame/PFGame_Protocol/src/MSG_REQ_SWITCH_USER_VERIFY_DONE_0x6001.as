package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SWITCH_USER_VERIFY_DONE_0x6001 extends MsgBase
	{
		public var t_user:uint;
		
		public function MSG_REQ_SWITCH_USER_VERIFY_DONE_0x6001()
		{
			super(0x6001)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(t_user);			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_LEAVE_USER_0x1001 extends MsgBase
	{
		
		public function MSG_REQ_WORLD_LEAVE_USER_0x1001()
		{
			super(0x1001)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
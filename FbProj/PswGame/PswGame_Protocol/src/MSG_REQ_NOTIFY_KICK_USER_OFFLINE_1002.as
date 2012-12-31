package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_NOTIFY_KICK_USER_OFFLINE_1002 extends MsgBase
	{
		
		public function MSG_REQ_NOTIFY_KICK_USER_OFFLINE_1002()
		{
			super(1002)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
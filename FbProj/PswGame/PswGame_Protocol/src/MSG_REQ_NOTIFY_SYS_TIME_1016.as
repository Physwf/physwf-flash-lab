package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_NOTIFY_SYS_TIME_1016 extends MsgBase
	{
		
		public function MSG_REQ_NOTIFY_SYS_TIME_1016()
		{
			super(1016)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
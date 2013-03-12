package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_SYS_TIME_1003 extends MsgBase
	{
		
		public function MSG_REQ_GET_SYS_TIME_1003()
		{
			super(1003)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_CANCEL_TASK_1021 extends MsgBase
	{
		public var tskid:uint;
		
		public function MSG_REQ_CANCEL_TASK_1021()
		{
			super(1021)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeInt(tskid);			
		}
	}
}
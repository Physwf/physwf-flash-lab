package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_CANCEL_TASK_1111 extends MsgBase
	{
		public var tskid:uint;
		
		public function MSG_REQ_CANCEL_TASK_1111()
		{
			super(1111)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(tskid);			
		}
	}
}
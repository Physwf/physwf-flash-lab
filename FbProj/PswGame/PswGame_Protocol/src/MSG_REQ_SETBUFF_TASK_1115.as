package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SETBUFF_TASK_1115 extends MsgBase
	{
		public var tskid:uint;
		public var step:uint;
		
		public function MSG_REQ_SETBUFF_TASK_1115()
		{
			super(1115)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(tskid);
			output.writeUnsignedInt(step);			
		}
	}
}
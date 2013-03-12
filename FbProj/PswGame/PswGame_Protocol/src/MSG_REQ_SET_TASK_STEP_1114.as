package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SET_TASK_STEP_1114 extends MsgBase
	{
		public var tskid:uint;
		public var step:uint;
		
		public function MSG_REQ_SET_TASK_STEP_1114()
		{
			super(1114)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(tskid);
			output.writeUnsignedInt(step);			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SET_TASK_STEP_1114 extends MsgBase
	{
		public var tskid:uint;
		public var step:uint;
		
		public function MSG_RES_SET_TASK_STEP_1114(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			tskid = input.readUnsignedInt();
			step = input.readUnsignedInt();			
		}
	}
}
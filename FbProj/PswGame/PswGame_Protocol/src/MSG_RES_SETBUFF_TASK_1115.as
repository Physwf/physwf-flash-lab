package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SETBUFF_TASK_1115 extends MsgBase
	{
		public var tskid:uint;
		public var step:uint;
		
		public function MSG_RES_SETBUFF_TASK_1115(mid:uint)
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
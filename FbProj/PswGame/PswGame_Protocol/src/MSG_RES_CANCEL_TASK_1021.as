package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_CANCEL_TASK_1021 extends MsgBase
	{
		public var tskid:uint;
		
		public function MSG_RES_CANCEL_TASK_1021(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			tskid = input.readUnsignedInt();			
		}
	}
}
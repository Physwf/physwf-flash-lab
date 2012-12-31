package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_TASK_FLAG_LIST_1023 extends MsgBase
	{
		public var begin_tskid:uint;
		public var end_tskid:uint;
		
		public function MSG_REQ_GET_TASK_FLAG_LIST_1023()
		{
			super(1023)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeInt(begin_tskid);
			output.writeInt(end_tskid);			
		}
	}
}
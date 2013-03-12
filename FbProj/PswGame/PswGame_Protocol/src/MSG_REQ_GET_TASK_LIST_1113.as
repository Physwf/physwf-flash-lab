package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_TASK_LIST_1113 extends MsgBase
	{
		public var begin_tskid:uint;
		public var end_tskid:uint;
		
		public function MSG_REQ_GET_TASK_LIST_1113()
		{
			super(1113)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(begin_tskid);
			output.writeUnsignedInt(end_tskid);			
		}
	}
}
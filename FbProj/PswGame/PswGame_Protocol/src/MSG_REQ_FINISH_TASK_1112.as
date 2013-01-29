package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_FINISH_TASK_1112 extends MsgBase
	{
		public var tskid:uint;
		public var optional_pos:uint;
		
		public function MSG_REQ_FINISH_TASK_1112()
		{
			super(1112)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(tskid);
			output.writeUnsignedInt(optional_pos);			
		}
	}
}
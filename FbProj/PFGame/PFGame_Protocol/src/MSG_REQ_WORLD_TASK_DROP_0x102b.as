package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_TASK_DROP_0x102b extends MsgBase
	{
		public var task_id:uint;
		
		public function MSG_REQ_WORLD_TASK_DROP_0x102b()
		{
			super(0x102b)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(task_id);			
		}
	}
}
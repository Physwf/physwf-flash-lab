package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_TASK_STEP_RATE_UPDATE_0x102c extends MsgBase
	{
		public var task_id:uint;
		public var step_id:uint;
		
		public function MSG_REQ_WORLD_TASK_STEP_RATE_UPDATE_0x102c()
		{
			super(0x102c)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(task_id);
			output.writeShort(step_id);			
		}
	}
}
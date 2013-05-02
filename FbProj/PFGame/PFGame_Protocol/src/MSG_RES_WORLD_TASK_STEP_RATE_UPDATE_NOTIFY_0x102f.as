package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_TASK_STEP_RATE_UPDATE_NOTIFY_0x102f extends MsgBase
	{
		public var task_id:uint;
		public var step_id:uint;
		public var rate:uint;
		
		public function MSG_RES_WORLD_TASK_STEP_RATE_UPDATE_NOTIFY_0x102f(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			task_id = input.readUnsignedInt();
			step_id = input.readUnsignedShort();
			rate = input.readUnsignedShort();			
		}
	}
}
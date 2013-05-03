package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SWITCH_WORLD_NOTIFY_USER_NUM_0x6000 extends MsgBase
	{
		public var world_id:uint;
		public var user_num:uint;
		
		public function MSG_REQ_SWITCH_WORLD_NOTIFY_USER_NUM_0x6000()
		{
			super(0x6000)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(world_id);
			output.writeUnsignedInt(user_num);			
		}
	}
}
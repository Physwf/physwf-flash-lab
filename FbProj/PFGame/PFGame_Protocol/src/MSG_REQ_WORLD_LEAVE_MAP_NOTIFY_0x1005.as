package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_LEAVE_MAP_NOTIFY_0x1005 extends MsgBase
	{
		
		public function MSG_REQ_WORLD_LEAVE_MAP_NOTIFY_0x1005()
		{
			super(0x1005)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
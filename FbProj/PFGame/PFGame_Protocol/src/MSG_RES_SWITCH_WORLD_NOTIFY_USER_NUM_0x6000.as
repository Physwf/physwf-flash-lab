package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SWITCH_WORLD_NOTIFY_USER_NUM_0x6000 extends MsgBase
	{
		
		public function MSG_RES_SWITCH_WORLD_NOTIFY_USER_NUM_0x6000(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			
		}
	}
}
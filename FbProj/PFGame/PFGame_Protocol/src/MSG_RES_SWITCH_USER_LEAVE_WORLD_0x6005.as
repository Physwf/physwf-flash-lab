package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SWITCH_USER_LEAVE_WORLD_0x6005 extends MsgBase
	{
		
		public function MSG_RES_SWITCH_USER_LEAVE_WORLD_0x6005(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			
		}
	}
}
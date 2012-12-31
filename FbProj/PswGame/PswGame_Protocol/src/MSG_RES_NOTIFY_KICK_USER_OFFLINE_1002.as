package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTIFY_KICK_USER_OFFLINE_1002 extends MsgBase
	{
		
		public function MSG_RES_NOTIFY_KICK_USER_OFFLINE_1002(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			
		}
	}
}
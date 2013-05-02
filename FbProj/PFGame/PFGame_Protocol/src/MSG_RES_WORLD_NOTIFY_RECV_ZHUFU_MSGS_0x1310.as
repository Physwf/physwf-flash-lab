package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_NOTIFY_RECV_ZHUFU_MSGS_0x1310 extends MsgBase
	{
		public var msg:recv_zhufu_msg_t;
		
		public function MSG_RES_WORLD_NOTIFY_RECV_ZHUFU_MSGS_0x1310(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			msg= new recv_zhufu_msg_t();
			msg.readExternal(input)			
		}
	}
}
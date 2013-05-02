package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_NOTIFY_ADD_MSG_0x130b extends MsgBase
	{
		public var msg:db_msg_t;
		
		public function MSG_RES_WORLD_NOTIFY_ADD_MSG_0x130b(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			msg= new db_msg_t();
			msg.readExternal(input)			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_REQ_ADD_MSG_0x131b extends MsgBase
	{
		public var msg:db_msg_t;
		
		public function MSG_REQ_WORLD_USER_REQ_ADD_MSG_0x131b()
		{
			super(0x131b)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			msg.writeExternal(output)			
		}
	}
}
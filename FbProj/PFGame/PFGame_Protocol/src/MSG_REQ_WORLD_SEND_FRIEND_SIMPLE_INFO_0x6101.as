package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_SEND_FRIEND_SIMPLE_INFO_0x6101 extends MsgBase
	{
		public var user_simple_info:user_simple_info_t;
		
		public function MSG_REQ_WORLD_SEND_FRIEND_SIMPLE_INFO_0x6101()
		{
			super(0x6101)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			user_simple_info.writeExternal(output)			
		}
	}
}
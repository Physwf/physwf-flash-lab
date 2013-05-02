package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_NOTIFY_FRIEND_SIMPLE_INFO_0x130a extends MsgBase
	{
		public var user_simple_info:user_simple_info_t;
		
		public function MSG_RES_WORLD_NOTIFY_FRIEND_SIMPLE_INFO_0x130a(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_simple_info= new user_simple_info_t();
			user_simple_info.readExternal(input)			
		}
	}
}
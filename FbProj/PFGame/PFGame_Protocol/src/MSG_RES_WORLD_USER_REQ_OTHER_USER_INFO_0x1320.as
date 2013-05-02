package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_REQ_OTHER_USER_INFO_0x1320 extends MsgBase
	{
		public var user_info:other_user_info_t;
		
		public function MSG_RES_WORLD_USER_REQ_OTHER_USER_INFO_0x1320(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_info= new other_user_info_t();
			user_info.readExternal(input)			
		}
	}
}
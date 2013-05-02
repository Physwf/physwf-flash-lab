package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SWITCH_REQ_ZHUFU_0x1311 extends MsgBase
	{
		public var user_info:base_user_info_t;
		
		public function MSG_RES_SWITCH_REQ_ZHUFU_0x1311(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_info= new base_user_info_t();
			user_info.readExternal(input)			
		}
	}
}
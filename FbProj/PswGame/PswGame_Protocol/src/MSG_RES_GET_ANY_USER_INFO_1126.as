package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_ANY_USER_INFO_1126 extends MsgBase
	{
		public var user:stru_any_user_t;
		
		public function MSG_RES_GET_ANY_USER_INFO_1126(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user= new stru_any_user_t();
			user.readExternal(input)			
		}
	}
}
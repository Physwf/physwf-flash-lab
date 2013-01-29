package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_LOGIN_1001 extends MsgBase
	{
		public var user:stru_user_t;
		
		public function MSG_RES_LOGIN_1001(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user= new stru_user_t();
			user.readExternal(input)			
		}
	}
}
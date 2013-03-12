package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_USER_REBIRTH_1046 extends MsgBase
	{
		public var user:map_user_info;
		
		public function MSG_RES_NOTI_USER_REBIRTH_1046(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user= new map_user_info();
			user.readExternal(input)			
		}
	}
}
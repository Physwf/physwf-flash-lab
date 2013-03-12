package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_ADD_FRIEND_1076 extends MsgBase
	{
		public var user:uid_role_t;
		public var user_nick:String;
		public var user_nick_data:ByteArray
		
		public function MSG_RES_NOTI_ADD_FRIEND_1076(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user= new uid_role_t();
			user.readExternal(input)
			user_nick = input.readUTFBytes(32);			
		}
	}
}
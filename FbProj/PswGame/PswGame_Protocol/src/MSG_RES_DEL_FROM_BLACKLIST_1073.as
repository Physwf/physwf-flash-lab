package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_DEL_FROM_BLACKLIST_1073 extends MsgBase
	{
		public var user:uid_role_t;
		public var unblacked_user_nick:String;
		public var unblacked_user_nick_data:ByteArray
		
		public function MSG_RES_DEL_FROM_BLACKLIST_1073(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user= new uid_role_t();
			user.readExternal(input)
			unblacked_user_nick = input.readUTFBytes(32);			
		}
	}
}
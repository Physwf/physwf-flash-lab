package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_ADD_TO_BLACKLIST_1005 extends MsgBase
	{
		public var user:uid_role_t;
		public var blacked_user_nick:String;
		
		public function MSG_RES_ADD_TO_BLACKLIST_1005(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user= new uid_role_t();
			user.readExternal(input)
			blacked_user_nick = input.readUTFBytes(32);			
		}
	}
}
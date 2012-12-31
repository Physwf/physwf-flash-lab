package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_DEL_FRIEND_1003 extends MsgBase
	{
		public var user:uid_role_t;
		public var nick:String;
		
		public function MSG_RES_DEL_FRIEND_1003(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user= new uid_role_t();
			user.readExternal(input)
			nick = input.readUTFBytes(16);			
		}
	}
}
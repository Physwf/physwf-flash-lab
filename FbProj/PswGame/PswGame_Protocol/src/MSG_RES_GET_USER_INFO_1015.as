package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_USER_INFO_1015 extends MsgBase
	{
		public var userid:uint;
		public var role_tm:uint;
		public var nick:String;
		public var nick_data:ByteArray
		
		public function MSG_RES_GET_USER_INFO_1015(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			userid = input.readUnsignedInt();
			role_tm = input.readUnsignedInt();
			nick = input.readUTFBytes(16);			
		}
	}
}
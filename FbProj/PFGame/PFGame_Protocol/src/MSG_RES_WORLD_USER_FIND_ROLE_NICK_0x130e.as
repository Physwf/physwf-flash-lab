package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_FIND_ROLE_NICK_0x130e extends MsgBase
	{
		public var uid:uint;
		public var nick:String;
		public var nick_data:ByteArray
		
		public function MSG_RES_WORLD_USER_FIND_ROLE_NICK_0x130e(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			uid = input.readUnsignedInt();
			nick = input.readUTF();			
		}
	}
}
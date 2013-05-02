package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_FIND_ROLE_NICK_0x130e extends MsgBase
	{
		public var uid:uint;
		
		public function MSG_REQ_WORLD_USER_FIND_ROLE_NICK_0x130e()
		{
			super(0x130e)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);			
		}
	}
}
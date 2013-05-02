package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_ADD_FRIEND_OFFLINE_MSG_0x1309 extends MsgBase
	{
		public var uid:uint;
		
		public function MSG_RES_WORLD_USER_ADD_FRIEND_OFFLINE_MSG_0x1309(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			uid = input.readUnsignedInt();			
		}
	}
}
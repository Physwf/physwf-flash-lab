package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_FRIEND_OFFLINE_0x130d extends MsgBase
	{
		public var uid:uint;
		
		public function MSG_RES_WORLD_USER_FRIEND_OFFLINE_0x130d(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			uid = input.readUnsignedInt();			
		}
	}
}
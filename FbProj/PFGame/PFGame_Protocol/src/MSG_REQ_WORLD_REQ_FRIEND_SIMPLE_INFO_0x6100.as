package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_REQ_FRIEND_SIMPLE_INFO_0x6100 extends MsgBase
	{
		public var uid:uint;
		
		public function MSG_REQ_WORLD_REQ_FRIEND_SIMPLE_INFO_0x6100()
		{
			super(0x6100)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);			
		}
	}
}
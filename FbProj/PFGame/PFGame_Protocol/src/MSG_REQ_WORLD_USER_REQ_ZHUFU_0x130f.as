package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_REQ_ZHUFU_0x130f extends MsgBase
	{
		public var uid:uint;
		
		public function MSG_REQ_WORLD_USER_REQ_ZHUFU_0x130f()
		{
			super(0x130f)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);			
		}
	}
}
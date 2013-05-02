package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_REQ_ADD_BLACK_0x1307 extends MsgBase
	{
		public var uid:uint;
		
		public function MSG_REQ_WORLD_USER_REQ_ADD_BLACK_0x1307()
		{
			super(0x1307)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);			
		}
	}
}
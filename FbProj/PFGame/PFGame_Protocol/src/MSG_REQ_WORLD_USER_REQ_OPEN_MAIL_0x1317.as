package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_REQ_OPEN_MAIL_0x1317 extends MsgBase
	{
		public var sn:uint;
		
		public function MSG_REQ_WORLD_USER_REQ_OPEN_MAIL_0x1317()
		{
			super(0x1317)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(sn);			
		}
	}
}
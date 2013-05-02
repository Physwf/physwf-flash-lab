package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_REQ_OPEN_MAIL_0x1317 extends MsgBase
	{
		public var sn:uint;
		
		public function MSG_RES_WORLD_USER_REQ_OPEN_MAIL_0x1317(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			sn = input.readUnsignedInt();			
		}
	}
}
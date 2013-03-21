package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RESGATEWAY_SEND_MAIL_WITH_ENCLOSURE_5003 extends MsgBase
	{
		public var recv_id:uint;
		public var recv_role_tm:uint;
		
		public function MSG_RESGATEWAY_SEND_MAIL_WITH_ENCLOSURE_5003(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			recv_id = input.readUnsignedInt();
			recv_role_tm = input.readUnsignedInt();			
		}
	}
}
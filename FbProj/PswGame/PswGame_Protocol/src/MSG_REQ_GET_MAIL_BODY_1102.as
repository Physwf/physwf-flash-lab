package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_MAIL_BODY_1102 extends MsgBase
	{
		public var mail_id:uint;
		
		public function MSG_REQ_GET_MAIL_BODY_1102()
		{
			super(1102)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(mail_id);			
		}
	}
}
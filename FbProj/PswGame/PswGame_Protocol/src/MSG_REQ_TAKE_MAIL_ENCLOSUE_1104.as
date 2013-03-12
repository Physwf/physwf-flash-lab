package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_TAKE_MAIL_ENCLOSUE_1104 extends MsgBase
	{
		public var mail_id:uint;
		
		public function MSG_REQ_TAKE_MAIL_ENCLOSUE_1104()
		{
			super(1104)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(mail_id);			
		}
	}
}
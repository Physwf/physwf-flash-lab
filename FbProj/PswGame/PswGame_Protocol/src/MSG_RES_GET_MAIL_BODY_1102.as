package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_MAIL_BODY_1102 extends MsgBase
	{
		public var mail_id:uint;
		public var mail_body:mail_body_t;
		
		public function MSG_RES_GET_MAIL_BODY_1102(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			mail_id = input.readUnsignedInt();
			mail_body= new mail_body_t();
			mail_body.readExternal(input)			
		}
	}
}
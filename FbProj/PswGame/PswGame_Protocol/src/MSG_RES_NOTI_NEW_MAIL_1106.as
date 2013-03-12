package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_NEW_MAIL_1106 extends MsgBase
	{
		public var mails:mail_head_t;
		
		public function MSG_RES_NOTI_NEW_MAIL_1106(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			mails= new mail_head_t();
			mails.readExternal(input)			
		}
	}
}
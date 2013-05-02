package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_NOTIFY_ADD_MAIL_0x1319 extends MsgBase
	{
		public var mail:mail_t;
		
		public function MSG_RES_WORLD_NOTIFY_ADD_MAIL_0x1319(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			mail= new mail_t();
			mail.readExternal(input)			
		}
	}
}
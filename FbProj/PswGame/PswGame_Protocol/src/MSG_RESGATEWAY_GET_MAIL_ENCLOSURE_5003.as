package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RESGATEWAY_GET_MAIL_ENCLOSURE_5003 extends MsgBase
	{
		public var enclosure:mail_enclosure_t;
		
		public function MSG_RESGATEWAY_GET_MAIL_ENCLOSURE_5003(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			enclosure= new mail_enclosure_t();
			enclosure.readExternal(input)			
		}
	}
}
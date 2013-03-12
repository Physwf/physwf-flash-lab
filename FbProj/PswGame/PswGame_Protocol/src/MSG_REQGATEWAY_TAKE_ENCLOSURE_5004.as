package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQGATEWAY_TAKE_ENCLOSURE_5004 extends MsgBase
	{
		public var mail_id:uint;
		public var enclosure:mail_enclosure_t;
		
		public function MSG_REQGATEWAY_TAKE_ENCLOSURE_5004()
		{
			super(5004)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(mail_id);
			enclosure.writeExternal(output)			
		}
	}
}
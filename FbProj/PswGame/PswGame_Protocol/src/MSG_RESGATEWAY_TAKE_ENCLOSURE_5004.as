package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RESGATEWAY_TAKE_ENCLOSURE_5004 extends MsgBase
	{
		public var mail_id:uint;
		
		public function MSG_RESGATEWAY_TAKE_ENCLOSURE_5004(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			mail_id = input.readUnsignedInt();			
		}
	}
}
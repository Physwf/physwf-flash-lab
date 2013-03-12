package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_DEL_MAIL_1103 extends MsgBase
	{
		public var mail_id:uint;
		
		public function MSG_RES_DEL_MAIL_1103(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			mail_id = input.readUnsignedInt();			
		}
	}
}
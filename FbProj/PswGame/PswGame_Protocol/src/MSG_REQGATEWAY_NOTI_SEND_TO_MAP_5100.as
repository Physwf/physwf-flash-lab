package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQGATEWAY_NOTI_SEND_TO_MAP_5100 extends MsgBase
	{
		
		public function MSG_REQGATEWAY_NOTI_SEND_TO_MAP_5100()
		{
			super(5100)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQGATEWAY_REPORT_TO_MAPSERV_5000 extends MsgBase
	{
		
		public function MSG_REQGATEWAY_REPORT_TO_MAPSERV_5000()
		{
			super(5000)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
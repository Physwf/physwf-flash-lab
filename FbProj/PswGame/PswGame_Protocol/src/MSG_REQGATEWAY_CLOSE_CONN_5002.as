package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQGATEWAY_CLOSE_CONN_5002 extends MsgBase
	{
		
		public function MSG_REQGATEWAY_CLOSE_CONN_5002()
		{
			super(5002)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
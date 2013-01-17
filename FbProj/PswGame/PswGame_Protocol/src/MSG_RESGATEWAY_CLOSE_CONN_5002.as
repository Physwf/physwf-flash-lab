package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RESGATEWAY_CLOSE_CONN_5002 extends MsgBase
	{
		
		public function MSG_RESGATEWAY_CLOSE_CONN_5002(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			
		}
	}
}
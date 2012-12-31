package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_ONLINE_VERSION_1000 extends MsgBase
	{
		
		public function MSG_REQ_GET_ONLINE_VERSION_1000()
		{
			super(1000)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
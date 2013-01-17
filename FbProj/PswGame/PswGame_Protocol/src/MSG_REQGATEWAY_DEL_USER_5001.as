package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQGATEWAY_DEL_USER_5001 extends MsgBase
	{
		
		public function MSG_REQGATEWAY_DEL_USER_5001()
		{
			super(5001)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_BLACKLIST_1011 extends MsgBase
	{
		
		public function MSG_REQ_GET_BLACKLIST_1011()
		{
			super(1011)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
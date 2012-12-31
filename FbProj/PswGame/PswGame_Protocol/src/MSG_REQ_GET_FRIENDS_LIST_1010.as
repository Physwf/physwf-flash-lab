package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_FRIENDS_LIST_1010 extends MsgBase
	{
		
		public function MSG_REQ_GET_FRIENDS_LIST_1010()
		{
			super(1010)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
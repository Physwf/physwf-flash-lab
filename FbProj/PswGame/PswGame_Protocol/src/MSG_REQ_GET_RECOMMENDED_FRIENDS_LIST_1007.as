package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_RECOMMENDED_FRIENDS_LIST_1007 extends MsgBase
	{
		
		public function MSG_REQ_GET_RECOMMENDED_FRIENDS_LIST_1007()
		{
			super(1007)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
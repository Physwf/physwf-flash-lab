package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_ONLINE_VERSION_1000 extends MsgBase
	{
		
		public function MSG_RES_GET_ONLINE_VERSION_1000(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			
		}
	}
}
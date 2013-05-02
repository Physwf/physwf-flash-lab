package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_GET_MAP_USER_0x1007 extends MsgBase
	{
		
		public function MSG_REQ_WORLD_GET_MAP_USER_0x1007()
		{
			super(0x1007)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
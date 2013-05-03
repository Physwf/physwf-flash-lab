package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SWITCH_USER_INTO_WORLD_0x6003 extends MsgBase
	{
		
		public function MSG_REQ_SWITCH_USER_INTO_WORLD_0x6003()
		{
			super(0x6003)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_KICK_USER_0x1000 extends MsgBase
	{
		
		public function MSG_REQ_WORLD_KICK_USER_0x1000()
		{
			super(0x1000)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
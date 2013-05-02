package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_ENTER_0x1002 extends MsgBase
	{
		public var world_id:uint;
		
		public function MSG_REQ_WORLD_USER_ENTER_0x1002()
		{
			super(0x1002)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(world_id);			
		}
	}
}
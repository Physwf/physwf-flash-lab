package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_PET_STEP_UP_0x1017 extends MsgBase
	{
		public var key:uint;
		
		public function MSG_REQ_WORLD_USER_PET_STEP_UP_0x1017()
		{
			super(0x1017)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(key);			
		}
	}
}
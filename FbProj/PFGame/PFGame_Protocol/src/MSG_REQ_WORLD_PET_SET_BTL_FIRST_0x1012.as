package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_PET_SET_BTL_FIRST_0x1012 extends MsgBase
	{
		public var key:uint;
		
		public function MSG_REQ_WORLD_PET_SET_BTL_FIRST_0x1012()
		{
			super(0x1012)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(key);			
		}
	}
}
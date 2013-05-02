package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_PET_SET_BTL_0x1013 extends MsgBase
	{
		public var key:uint;
		
		public function MSG_REQ_WORLD_PET_SET_BTL_0x1013()
		{
			super(0x1013)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(key);			
		}
	}
}
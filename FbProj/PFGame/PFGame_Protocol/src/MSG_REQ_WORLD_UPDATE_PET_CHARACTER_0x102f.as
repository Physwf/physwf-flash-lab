package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_UPDATE_PET_CHARACTER_0x102f extends MsgBase
	{
		public var pet_key:uint;
		
		public function MSG_REQ_WORLD_UPDATE_PET_CHARACTER_0x102f()
		{
			super(0x102f)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(pet_key);			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_PUT_OFF_PET_EQUIPMENT_0x101e extends MsgBase
	{
		public var pet_key:uint;
		public var pos:uint;
		
		public function MSG_REQ_WORLD_USER_PUT_OFF_PET_EQUIPMENT_0x101e()
		{
			super(0x101e)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(pet_key);
			output.writeUnsignedInt(pos);			
		}
	}
}
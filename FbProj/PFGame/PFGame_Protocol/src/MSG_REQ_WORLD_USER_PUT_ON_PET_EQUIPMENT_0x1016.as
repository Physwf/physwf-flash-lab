package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_USER_PUT_ON_PET_EQUIPMENT_0x1016 extends MsgBase
	{
		public var pos:uint;
		public var pet_key:uint;
		
		public function MSG_REQ_WORLD_USER_PUT_ON_PET_EQUIPMENT_0x1016()
		{
			super(0x1016)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(pos);
			output.writeUnsignedInt(pet_key);			
		}
	}
}
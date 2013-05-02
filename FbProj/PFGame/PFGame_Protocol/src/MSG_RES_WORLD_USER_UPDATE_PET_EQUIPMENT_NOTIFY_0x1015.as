package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_USER_UPDATE_PET_EQUIPMENT_NOTIFY_0x1015 extends MsgBase
	{
		public var data:db_pet_equipment_t;
		public var cnt:uint;
		
		public function MSG_RES_WORLD_USER_UPDATE_PET_EQUIPMENT_NOTIFY_0x1015(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			data= new db_pet_equipment_t();
			data.readExternal(input)
			cnt = input.readUnsignedByte();			
		}
	}
}
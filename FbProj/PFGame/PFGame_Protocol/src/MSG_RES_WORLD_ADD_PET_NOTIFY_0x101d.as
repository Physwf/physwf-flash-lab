package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_ADD_PET_NOTIFY_0x101d extends MsgBase
	{
		public var pet:db_pet_t;
		
		public function MSG_RES_WORLD_ADD_PET_NOTIFY_0x101d(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			pet= new db_pet_t();
			pet.readExternal(input)			
		}
	}
}
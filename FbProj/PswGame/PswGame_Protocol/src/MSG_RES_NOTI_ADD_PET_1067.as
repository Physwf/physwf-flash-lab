package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_ADD_PET_1067 extends MsgBase
	{
		public var pet:stru_pet_t;
		
		public function MSG_RES_NOTI_ADD_PET_1067(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			pet= new stru_pet_t();
			pet.readExternal(input)			
		}
	}
}
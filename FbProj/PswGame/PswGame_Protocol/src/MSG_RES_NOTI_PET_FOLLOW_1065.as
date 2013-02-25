package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_NOTI_PET_FOLLOW_1065 extends MsgBase
	{
		public var uid:uint;
		public var pet:stru_pet_simple_t;
		
		public function MSG_RES_NOTI_PET_FOLLOW_1065(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			uid = input.readUnsignedInt();
			pet= new stru_pet_simple_t();
			pet.readExternal(input)			
		}
	}
}
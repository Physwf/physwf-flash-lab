package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_CATCH_PET_1068 extends MsgBase
	{
		public var pet:stru_pet_t;
		
		public function MSG_RES_CATCH_PET_1068(mid:uint)
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
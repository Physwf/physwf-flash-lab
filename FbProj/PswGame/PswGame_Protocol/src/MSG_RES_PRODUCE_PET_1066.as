package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_PRODUCE_PET_1066 extends MsgBase
	{
		public var pet:stru_pet_t;
		public var grid:uint;
		
		public function MSG_RES_PRODUCE_PET_1066(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			pet= new stru_pet_t();
			pet.readExternal(input)
			grid = input.readUnsignedShort();			
		}
	}
}
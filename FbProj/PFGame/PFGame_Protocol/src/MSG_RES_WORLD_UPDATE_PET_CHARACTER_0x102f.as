package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_UPDATE_PET_CHARACTER_0x102f extends MsgBase
	{
		public var pet_key:uint;
		public var character:uint;
		
		public function MSG_RES_WORLD_UPDATE_PET_CHARACTER_0x102f(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			pet_key = input.readUnsignedInt();
			character = input.readUnsignedByte();			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_UPDATE_PET_GROW_0x101a extends MsgBase
	{
		public var pet_key:uint;
		public var power_grow:uint;
		public var stamina_grow:uint;
		public var magic_grow:uint;
		public var speed_grow:uint;
		
		public function MSG_RES_WORLD_UPDATE_PET_GROW_0x101a(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			pet_key = input.readUnsignedInt();
			power_grow = input.readUnsignedShort();
			stamina_grow = input.readUnsignedShort();
			magic_grow = input.readUnsignedShort();
			speed_grow = input.readUnsignedShort();			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_ATTACK_BY_POS_1048 extends MsgBase
	{
		public var src_id:uint;
		public var src_type:uint;
		public var skill_id:uint;
		public var map_x:uint;
		public var map_y:uint;
		
		public function MSG_RES_ATTACK_BY_POS_1048(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			src_id = input.readUnsignedInt();
			src_type = input.readUnsignedByte();
			skill_id = input.readUnsignedShort();
			map_x = input.readUnsignedShort();
			map_y = input.readUnsignedShort();			
		}
	}
}
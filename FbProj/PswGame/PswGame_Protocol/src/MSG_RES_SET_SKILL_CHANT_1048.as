package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SET_SKILL_CHANT_1048 extends MsgBase
	{
		public var user_id:uint;
		public var skill_id:uint;
		public var direction:uint;
		
		public function MSG_RES_SET_SKILL_CHANT_1048(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			user_id = input.readUnsignedInt();
			skill_id = input.readUnsignedShort();
			direction = input.readUnsignedByte();			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_BATTLE_ATTACK_1040 extends MsgBase
	{
		public var pet_id:uint;
		public var obj_id:uint;
		public var obj_type:uint;
		public var skill_id:uint;
		
		public function MSG_REQ_BATTLE_ATTACK_1040()
		{
			super(1040)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(pet_id);
			output.writeUnsignedInt(obj_id);
			output.writeShort(obj_type);
			output.writeShort(skill_id);			
		}
	}
}
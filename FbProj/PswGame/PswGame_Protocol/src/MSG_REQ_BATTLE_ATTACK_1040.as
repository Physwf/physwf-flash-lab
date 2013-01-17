package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_BATTLE_ATTACK_1040 extends MsgBase
	{
		public var src_id:uint;
		public var pet_id:uint;
		public var src_type:uint;
		public var obj_id:uint;
		public var obj_type:uint;
		public var skill_id:uint;
		
		public function MSG_REQ_BATTLE_ATTACK_1040()
		{
			super(1040)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeInt(src_id);
			output.writeInt(pet_id);
			output.writeInt(src_type);
			output.writeInt(obj_id);
			output.writeInt(obj_type);
			output.writeInt(skill_id);			
		}
	}
}
package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ATTACK_BY_OBJ_1040 extends MsgBase
	{
		public var src_type:uint;
		public var obj_type:uint;
		public var obj_id:uint;
		public var skill_id:uint;
		public var direction:uint;
		
		public function MSG_REQ_ATTACK_BY_OBJ_1040()
		{
			super(1040)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeByte(src_type);
			output.writeByte(obj_type);
			output.writeUnsignedInt(obj_id);
			output.writeShort(skill_id);
			output.writeByte(direction);			
		}
	}
}
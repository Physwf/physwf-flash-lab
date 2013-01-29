package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class atk_result_t implements IExternalizable
	{
		public var src_id:uint;
		public var src_type:uint;
		public var obj_id:uint;
		public var obj_type:uint;
		public var skill_id:uint;
		public var hp_hurt:uint;
		public var is_dead:uint;
		
		public function atk_result_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			src_id = input.readUnsignedInt();
			src_type = input.readUnsignedShort();
			obj_id = input.readUnsignedInt();
			obj_type = input.readUnsignedShort();
			skill_id = input.readUnsignedShort();
			hp_hurt = input.readUnsignedInt();
			is_dead = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(src_id);
			output.writeShort(src_type);
			output.writeUnsignedInt(obj_id);
			output.writeShort(obj_type);
			output.writeShort(skill_id);
			output.writeUnsignedInt(hp_hurt);
			output.writeByte(is_dead);			
		}
	}
}
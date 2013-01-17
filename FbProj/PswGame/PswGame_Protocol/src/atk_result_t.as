package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class atk_result_t implements IExternalizable
	{
		public var src_id:uint;
		public var pet_id:uint;
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
			pet_id = input.readUnsignedInt();
			src_type = input.readUnsignedInt();
			obj_id = input.readUnsignedInt();
			obj_type = input.readUnsignedInt();
			skill_id = input.readUnsignedInt();
			hp_hurt = input.readUnsignedInt();
			is_dead = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(src_id);
			output.writeInt(pet_id);
			output.writeInt(src_type);
			output.writeInt(obj_id);
			output.writeInt(obj_type);
			output.writeInt(skill_id);
			output.writeInt(hp_hurt);
			output.writeByte(is_dead);			
		}
	}
}
package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class atk_result_t implements IExternalizable
	{
		public var src_type:uint;
		public var src_id:uint;
		public var obj_type:uint;
		public var obj_id:uint;
		public var skill_id:uint;
		public var hp_hurt:uint;
		
		public function atk_result_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			src_type = input.readUnsignedByte();
			src_id = input.readUnsignedInt();
			obj_type = input.readUnsignedByte();
			obj_id = input.readUnsignedInt();
			skill_id = input.readUnsignedShort();
			hp_hurt = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeByte(src_type);
			output.writeUnsignedInt(src_id);
			output.writeByte(obj_type);
			output.writeUnsignedInt(obj_id);
			output.writeShort(skill_id);
			output.writeUnsignedInt(hp_hurt);			
		}
	}
}
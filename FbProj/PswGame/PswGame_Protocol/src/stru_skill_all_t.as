package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_skill_all_t implements IExternalizable
	{
		public var instance_id:uint;
		public var skill_id:uint;
		public var skill_lv:uint;
		
		public function stru_skill_all_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			instance_id = input.readUnsignedInt();
			skill_id = input.readUnsignedShort();
			skill_lv = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(instance_id);
			output.writeShort(skill_id);
			output.writeShort(skill_lv);			
		}
	}
}
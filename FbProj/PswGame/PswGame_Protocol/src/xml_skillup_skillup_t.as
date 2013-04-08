package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_skillup_skillup_t implements IExternalizable
	{
		public var skill_id:uint;
		public var skill_lv:uint;
		public var skill_exp:uint;
		public var skill_money:uint;
		public var groove:uint;
		public var user_lv:uint;
		
		public function xml_skillup_skillup_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			skill_id = input.readUnsignedInt();
			skill_lv = input.readUnsignedShort();
			skill_exp = input.readUnsignedInt();
			skill_money = input.readUnsignedInt();
			groove = input.readUnsignedByte();
			user_lv = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(skill_id);
			output.writeShort(skill_lv);
			output.writeUnsignedInt(skill_exp);
			output.writeUnsignedInt(skill_money);
			output.writeByte(groove);
			output.writeByte(user_lv);			
		}
	}
}
package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_skill_skill_t implements IExternalizable
	{
		public var skill_id:uint;
		public var role_type:uint;
		public var auto_atk_conti:uint;
		public var skill_type:uint;
		public var skill_lv:uint;
		public var user_lv:uint;
		public var mp_consumed:uint;
		public var hp_consumed:uint;
		public var sp_consumed:uint;
		public var cd:uint;
		public var target:uint;
		public var range_num:uint;
		public var range:uint;
		public var weapon_damage:uint;
		public var pro_damage:uint;
		public var enmity_type:uint;
		public var enmity:uint;
		public var per_damage:uint;
		public var buff_id:uint;
		
		public function xml_skill_skill_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			skill_id = input.readUnsignedShort();
			role_type = input.readUnsignedShort();
			auto_atk_conti = input.readUnsignedShort();
			skill_type = input.readUnsignedShort();
			skill_lv = input.readUnsignedShort();
			user_lv = input.readUnsignedShort();
			mp_consumed = input.readUnsignedShort();
			hp_consumed = input.readUnsignedShort();
			sp_consumed = input.readUnsignedShort();
			cd = input.readUnsignedShort();
			target = input.readUnsignedShort();
			range_num = input.readUnsignedShort();
			range = input.readUnsignedShort();
			weapon_damage = input.readUnsignedShort();
			pro_damage = input.readUnsignedShort();
			enmity_type = input.readUnsignedShort();
			enmity = input.readUnsignedShort();
			per_damage = input.readUnsignedShort();
			buff_id = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(skill_id);
			output.writeShort(role_type);
			output.writeShort(auto_atk_conti);
			output.writeShort(skill_type);
			output.writeShort(skill_lv);
			output.writeShort(user_lv);
			output.writeShort(mp_consumed);
			output.writeShort(hp_consumed);
			output.writeShort(sp_consumed);
			output.writeShort(cd);
			output.writeShort(target);
			output.writeShort(range_num);
			output.writeShort(range);
			output.writeShort(weapon_damage);
			output.writeShort(pro_damage);
			output.writeShort(enmity_type);
			output.writeShort(enmity);
			output.writeShort(per_damage);
			output.writeShort(buff_id);			
		}
	}
}
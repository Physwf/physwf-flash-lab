package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_soul_soul_t implements IExternalizable
	{
		public var soul_id:uint;
		public var role_type:uint;
		public var soul_lv:uint;
		public var user_lv:uint;
		public var skill_id:uint;
		public var phy_atk:uint;
		public var solar_atk:uint;
		public var phy_def:uint;
		public var solar_def:uint;
		public var hit:uint;
		public var dodge:uint;
		public var soul_hp_max:uint;
		public var soul_mp_max:uint;
		public var crit:uint;
		public var crit_damage:uint;
		
		public function xml_soul_soul_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			soul_id = input.readUnsignedShort();
			role_type = input.readUnsignedShort();
			soul_lv = input.readUnsignedShort();
			user_lv = input.readUnsignedShort();
			skill_id = input.readUnsignedShort();
			phy_atk = input.readUnsignedShort();
			solar_atk = input.readUnsignedShort();
			phy_def = input.readUnsignedShort();
			solar_def = input.readUnsignedShort();
			hit = input.readUnsignedShort();
			dodge = input.readUnsignedShort();
			soul_hp_max = input.readUnsignedShort();
			soul_mp_max = input.readUnsignedShort();
			crit = input.readUnsignedShort();
			crit_damage = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(soul_id);
			output.writeShort(role_type);
			output.writeShort(soul_lv);
			output.writeShort(user_lv);
			output.writeShort(skill_id);
			output.writeShort(phy_atk);
			output.writeShort(solar_atk);
			output.writeShort(phy_def);
			output.writeShort(solar_def);
			output.writeShort(hit);
			output.writeShort(dodge);
			output.writeShort(soul_hp_max);
			output.writeShort(soul_mp_max);
			output.writeShort(crit);
			output.writeShort(crit_damage);			
		}
	}
}
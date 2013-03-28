package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_equip_equip_t implements IExternalizable
	{
		public var equip_id:uint;
		public var category:uint;
		public var quality:uint;
		public var user_lv:uint;
		public var sell_price:uint;
		public var buy_price:uint;
		public var max_num:uint;
		public var tradeable:uint;
		public var distory:uint;
		public var accumulate:uint;
		public var equip_pos:uint;
		public var duration_time:uint;
		public var end_time:uint;
		public var strength:uint;
		public var solar:uint;
		public var physique:uint;
		public var spirit:uint;
		public var agility:uint;
		public var hp_max:uint;
		public var mp_max:uint;
		public var hp_max_pre:uint;
		public var mp_max_pre:uint;
		public var phy_atk:uint;
		public var solar_atk:uint;
		public var phy_def:uint;
		public var solar_def:uint;
		public var phy_def_pre:uint;
		public var solar_def_pre:uint;
		public var phy_atk_pre:uint;
		public var solar_atk_pre:uint;
		public var phy_def_lv:uint;
		public var solar_def_lv:uint;
		public var crit:uint;
		public var crit_damage:uint;
		public var crit_tenacity:uint;
		public var hit:uint;
		public var dodge:uint;
		public var earth_atk:uint;
		public var earth_def:uint;
		public var water_atk:uint;
		public var water_def:uint;
		public var wind_atk:uint;
		public var wind_def:uint;
		public var fire_atk:uint;
		public var fire_def:uint;
		public var durability:uint;
		
		public function xml_equip_equip_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			equip_id = input.readUnsignedInt();
			category = input.readUnsignedShort();
			quality = input.readUnsignedShort();
			user_lv = input.readUnsignedShort();
			sell_price = input.readUnsignedInt();
			buy_price = input.readUnsignedInt();
			max_num = input.readUnsignedShort();
			tradeable = input.readUnsignedShort();
			distory = input.readUnsignedShort();
			accumulate = input.readUnsignedShort();
			equip_pos = input.readUnsignedShort();
			duration_time = input.readUnsignedInt();
			end_time = input.readUnsignedInt();
			strength = input.readUnsignedShort();
			solar = input.readUnsignedShort();
			physique = input.readUnsignedShort();
			spirit = input.readUnsignedShort();
			agility = input.readUnsignedShort();
			hp_max = input.readUnsignedInt();
			mp_max = input.readUnsignedInt();
			hp_max_pre = input.readUnsignedShort();
			mp_max_pre = input.readUnsignedShort();
			phy_atk = input.readUnsignedInt();
			solar_atk = input.readUnsignedInt();
			phy_def = input.readUnsignedInt();
			solar_def = input.readUnsignedInt();
			phy_def_pre = input.readUnsignedByte();
			solar_def_pre = input.readUnsignedByte();
			phy_atk_pre = input.readUnsignedByte();
			solar_atk_pre = input.readUnsignedByte();
			phy_def_lv = input.readUnsignedShort();
			solar_def_lv = input.readUnsignedShort();
			crit = input.readUnsignedByte();
			crit_damage = input.readUnsignedByte();
			crit_tenacity = input.readUnsignedByte();
			hit = input.readUnsignedShort();
			dodge = input.readUnsignedShort();
			earth_atk = input.readUnsignedShort();
			earth_def = input.readUnsignedShort();
			water_atk = input.readUnsignedShort();
			water_def = input.readUnsignedShort();
			wind_atk = input.readUnsignedShort();
			wind_def = input.readUnsignedShort();
			fire_atk = input.readUnsignedShort();
			fire_def = input.readUnsignedShort();
			durability = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(equip_id);
			output.writeShort(category);
			output.writeShort(quality);
			output.writeShort(user_lv);
			output.writeUnsignedInt(sell_price);
			output.writeUnsignedInt(buy_price);
			output.writeShort(max_num);
			output.writeShort(tradeable);
			output.writeShort(distory);
			output.writeShort(accumulate);
			output.writeShort(equip_pos);
			output.writeUnsignedInt(duration_time);
			output.writeUnsignedInt(end_time);
			output.writeShort(strength);
			output.writeShort(solar);
			output.writeShort(physique);
			output.writeShort(spirit);
			output.writeShort(agility);
			output.writeUnsignedInt(hp_max);
			output.writeUnsignedInt(mp_max);
			output.writeShort(hp_max_pre);
			output.writeShort(mp_max_pre);
			output.writeUnsignedInt(phy_atk);
			output.writeUnsignedInt(solar_atk);
			output.writeUnsignedInt(phy_def);
			output.writeUnsignedInt(solar_def);
			output.writeByte(phy_def_pre);
			output.writeByte(solar_def_pre);
			output.writeByte(phy_atk_pre);
			output.writeByte(solar_atk_pre);
			output.writeShort(phy_def_lv);
			output.writeShort(solar_def_lv);
			output.writeByte(crit);
			output.writeByte(crit_damage);
			output.writeByte(crit_tenacity);
			output.writeShort(hit);
			output.writeShort(dodge);
			output.writeShort(earth_atk);
			output.writeShort(earth_def);
			output.writeShort(water_atk);
			output.writeShort(water_def);
			output.writeShort(wind_atk);
			output.writeShort(wind_def);
			output.writeShort(fire_atk);
			output.writeShort(fire_def);
			output.writeShort(durability);			
		}
	}
}
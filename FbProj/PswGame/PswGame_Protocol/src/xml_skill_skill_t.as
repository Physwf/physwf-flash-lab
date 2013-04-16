package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_skill_skill_t implements IExternalizable
	{
		public var skill_id:uint;
		public var skill_type:uint;
		public var role_type:uint;
		public var strike:uint;
		public var auto_atk_conti:uint;
		public var skill_lv:uint;
		public var user_lv:uint;
		public var mp_consumed:uint;
		public var hp_consumed:uint;
		public var sp_consumed:uint;
		public var cd:uint;
		public var mouse:uint;
		public var target_type:uint;
		public var range_num:uint;
		public var atk_distance:uint;
		public var direct_damage:uint;
		public var enmity_type:uint;
		public var enmity:uint;
		public var per_damage:uint;
		public var buff_id:Vector.<uint>;
		public var hit_area_type:uint;
		public var angle:uint;
		public var skill_radius:uint;
		public var height:uint;
		public var width:uint;
		public var speed:uint;
		public var falldown:uint;
		public var invoke_skill_id:uint;
		public var invoke_skill_odds:uint;
		public var chant_time:uint;
		public var chant_break:uint;
		public var genius_id:uint;
		public var trap_duration:uint;
		public var trap_damage:uint;
		public var add_phy_atk:uint;
		public var add_solar_atk:uint;
		public var add_earth_atk:uint;
		public var add_water_atk:uint;
		public var add_fire_atk:uint;
		public var add_wind_atk:uint;
		
		public function xml_skill_skill_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			skill_id = input.readUnsignedShort();
			skill_type = input.readUnsignedShort();
			role_type = input.readUnsignedByte();
			strike = input.readUnsignedByte();
			auto_atk_conti = input.readUnsignedByte();
			skill_lv = input.readUnsignedShort();
			user_lv = input.readUnsignedShort();
			mp_consumed = input.readUnsignedShort();
			hp_consumed = input.readUnsignedShort();
			sp_consumed = input.readUnsignedShort();
			cd = input.readUnsignedShort();
			mouse = input.readUnsignedByte();
			target_type = input.readUnsignedByte();
			range_num = input.readUnsignedShort();
			atk_distance = input.readUnsignedShort();
			direct_damage = input.readUnsignedShort();
			enmity_type = input.readUnsignedShort();
			enmity = input.readUnsignedShort();
			per_damage = input.readUnsignedShort();
			var buff_idLen:uint =input.readUnsignedInt();
			buff_id= new Vector.<uint>();
			for(var i:int=0;i<buff_idLen;++i)
			{
				var buff_id_item:uint = input.readUnsignedShort();;
				buff_id.push(buff_id_item);
			}
			hit_area_type = input.readUnsignedByte();
			angle = input.readUnsignedShort();
			skill_radius = input.readUnsignedShort();
			height = input.readUnsignedShort();
			width = input.readUnsignedShort();
			speed = input.readUnsignedShort();
			falldown = input.readUnsignedShort();
			invoke_skill_id = input.readUnsignedShort();
			invoke_skill_odds = input.readUnsignedShort();
			chant_time = input.readUnsignedInt();
			chant_break = input.readUnsignedByte();
			genius_id = input.readUnsignedShort();
			trap_duration = input.readUnsignedInt();
			trap_damage = input.readUnsignedByte();
			add_phy_atk = input.readUnsignedInt();
			add_solar_atk = input.readUnsignedInt();
			add_earth_atk = input.readUnsignedShort();
			add_water_atk = input.readUnsignedShort();
			add_fire_atk = input.readUnsignedShort();
			add_wind_atk = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(skill_id);
			output.writeShort(skill_type);
			output.writeByte(role_type);
			output.writeByte(strike);
			output.writeByte(auto_atk_conti);
			output.writeShort(skill_lv);
			output.writeShort(user_lv);
			output.writeShort(mp_consumed);
			output.writeShort(hp_consumed);
			output.writeShort(sp_consumed);
			output.writeShort(cd);
			output.writeByte(mouse);
			output.writeByte(target_type);
			output.writeShort(range_num);
			output.writeShort(atk_distance);
			output.writeShort(direct_damage);
			output.writeShort(enmity_type);
			output.writeShort(enmity);
			output.writeShort(per_damage);
			output.writeUnsignedInt(buff_id.length);
			for(var j:int=0;j<buff_id.length;++j)
			{
				output.writeShort(buff_id[j]);
			}
			output.writeByte(hit_area_type);
			output.writeShort(angle);
			output.writeShort(skill_radius);
			output.writeShort(height);
			output.writeShort(width);
			output.writeShort(speed);
			output.writeShort(falldown);
			output.writeShort(invoke_skill_id);
			output.writeShort(invoke_skill_odds);
			output.writeUnsignedInt(chant_time);
			output.writeByte(chant_break);
			output.writeShort(genius_id);
			output.writeUnsignedInt(trap_duration);
			output.writeByte(trap_damage);
			output.writeUnsignedInt(add_phy_atk);
			output.writeUnsignedInt(add_solar_atk);
			output.writeShort(add_earth_atk);
			output.writeShort(add_water_atk);
			output.writeShort(add_fire_atk);
			output.writeShort(add_wind_atk);			
		}
	}
}
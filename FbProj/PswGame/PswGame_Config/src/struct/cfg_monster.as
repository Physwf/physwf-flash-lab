package struct
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class cfg_monster implements IExternalizable
	{
		public var monster_id:uint;
		public var res_id:uint;
		public var ai:uint;
		public var ai_ext:uint;
		public var name:String;
		public var type:uint;
		public var dept:uint;
		public var monster_value:uint;
		public var level:uint;
		public var phy_atk:uint;
		public var phy_def:uint;
		public var solar_atk:uint;
		public var solar_def:uint;
		public var hp_max:uint;
		public var mp_max:uint;
		public var add_hp:uint;
		public var add_mp:uint;
		public var hit:uint;
		public var dodge:uint;
		public var crit:uint;
		public var crit_damage:uint;
		public var move_speed:uint;
		public var walk_speed:uint;
		public var atk_speed:uint;
		public var earth_atk:uint;
		public var earth_def:uint;
		public var water_atk:uint;
		public var water_def:uint;
		public var fire_atk:uint;
		public var fire_def:uint;
		public var wind_atk:uint;
		public var wind_def:uint;
		public var timed_imm:uint;
		public var continue_imm:uint;
		public var attacked:uint;
		public var exp:uint;
		public var friendliness:uint;
		public var takt_time:uint;
		public var camp:uint;
		public var drop_radius:uint;
		public var max_effect_group:uint;
		public var damage_in_percent:uint;
		public var drop_id:uint;
		public var interactive:uint;
		public var exterior:uint;
		public var head_info:uint;
		public var veer:uint;
		public var nameplate_height:uint;
		public var selected_ring:uint;
		public var shadow:uint;
		public var width:uint;
		public var height:uint;
		public var visual_field:uint;
		public var head_icon:uint;
		
		
		public function cfg_monster()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			monster_id = input.readUnsignedShort();
			res_id = input.readUnsignedShort();
			ai = input.readUnsignedByte();
			ai_ext = input.readUnsignedByte();
			var nameLen:uint = input.readUnsignedShort();
			name = input.readUTFBytes(nameLen);
			type = input.readUnsignedByte();
			dept = input.readUnsignedByte();
			monster_value = input.readUnsignedByte();
			level = input.readUnsignedByte();
			phy_atk = input.readUnsignedByte();
			phy_def = input.readUnsignedByte();
			solar_atk = input.readUnsignedByte();
			solar_def = input.readUnsignedByte();
			hp_max = input.readUnsignedByte();
			mp_max = input.readUnsignedByte();
			add_hp = input.readUnsignedByte();
			add_mp = input.readUnsignedByte();
			hit = input.readUnsignedByte();
			dodge = input.readUnsignedByte();
			crit = input.readUnsignedByte();
			crit_damage = input.readUnsignedByte();
			move_speed = input.readUnsignedByte();
			walk_speed = input.readUnsignedByte();
			atk_speed = input.readUnsignedByte();
			earth_atk = input.readUnsignedByte();
			earth_def = input.readUnsignedByte();
			water_atk = input.readUnsignedByte();
			water_def = input.readUnsignedByte();
			fire_atk = input.readUnsignedByte();
			fire_def = input.readUnsignedByte();
			wind_atk = input.readUnsignedByte();
			wind_def = input.readUnsignedByte();
			timed_imm = input.readUnsignedByte();
			continue_imm = input.readUnsignedByte();
			attacked = input.readUnsignedByte();
			exp = input.readUnsignedByte();
			friendliness = input.readUnsignedByte();
			takt_time = input.readUnsignedByte();
			camp = input.readUnsignedByte();
			drop_radius = input.readUnsignedByte();
			max_effect_group = input.readUnsignedByte();
			damage_in_percent = input.readUnsignedByte();
			drop_id = input.readUnsignedByte();
			interactive = input.readUnsignedByte();
			exterior = input.readUnsignedByte();
			head_info = input.readUnsignedByte();
			veer = input.readUnsignedByte();
			nameplate_height = input.readUnsignedByte();
			selected_ring = input.readUnsignedByte();
			shadow = input.readUnsignedByte();
			width = input.readUnsignedByte();
			height = input.readUnsignedByte();
			visual_field = input.readUnsignedByte();
			head_icon = input.readUnsignedByte();
			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(monster_id);
			output.writeShort(res_id);
			output.writeByte(ai);
			output.writeByte(ai_ext);
			var nameData:ByteArray = new ByteArray();
			nameData.writeUTFBytes(name);
			output.writeShort(nameData.length);
			output.writeBytes(nameData);
			output.writeByte(type);
			output.writeByte(dept);
			output.writeByte(monster_value);
			output.writeByte(level);
			output.writeByte(phy_atk);
			output.writeByte(phy_def);
			output.writeByte(solar_atk);
			output.writeByte(solar_def);
			output.writeByte(hp_max);
			output.writeByte(mp_max);
			output.writeByte(add_hp);
			output.writeByte(add_mp);
			output.writeByte(hit);
			output.writeByte(dodge);
			output.writeByte(crit);
			output.writeByte(crit_damage);
			output.writeByte(move_speed);
			output.writeByte(walk_speed);
			output.writeByte(atk_speed);
			output.writeByte(earth_atk);
			output.writeByte(earth_def);
			output.writeByte(water_atk);
			output.writeByte(water_def);
			output.writeByte(fire_atk);
			output.writeByte(fire_def);
			output.writeByte(wind_atk);
			output.writeByte(wind_def);
			output.writeByte(timed_imm);
			output.writeByte(continue_imm);
			output.writeByte(attacked);
			output.writeByte(exp);
			output.writeByte(friendliness);
			output.writeByte(takt_time);
			output.writeByte(camp);
			output.writeByte(drop_radius);
			output.writeByte(max_effect_group);
			output.writeByte(damage_in_percent);
			output.writeByte(drop_id);
			output.writeByte(interactive);
			output.writeByte(exterior);
			output.writeByte(head_info);
			output.writeByte(veer);
			output.writeByte(nameplate_height);
			output.writeByte(selected_ring);
			output.writeByte(shadow);
			output.writeByte(width);
			output.writeByte(height);
			output.writeByte(visual_field);
			output.writeByte(head_icon);
			
		}
		
	}
}
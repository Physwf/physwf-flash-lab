package com.physwf.config.struct
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class cfg_monster implements IExternalizable
	{
		public var monster_id:uint;
		public var res_id:uint;
		public var head_icon:uint;
		public var name:String;
		public var level:uint;
		public var attack:uint;
		public var type:uint;
		public var dept:uint;
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
		public var earth_atk:uint;
		public var earth_def:uint;
		public var water_atk:uint;
		public var water_def:uint;
		public var fire_atk:uint;
		public var fire_def:uint;
		public var wind_atk:uint;
		public var wind_def:uint;
		public var exp:uint;
		public var width:uint;
		public var height:uint;
		public var drop_id:uint;
		public var pet_id:uint;
		public var pet_ratio:uint;
		public var success_chance:uint;
		public var pet_catch_aging:uint;
		public var pet_catch_time:uint;
		public var pet_catch:uint;
		public var skill_ai_type:uint;
		public var use_type:uint;
		public var skill_ai_id:uint;
		public var ai_key:uint;
		public var use_once:uint;
		public var use_time:uint;
		
		
		public function cfg_monster()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			monster_id = input.readUnsignedInt();
			res_id = input.readUnsignedInt();
			head_icon = input.readUnsignedInt();
			var nameLen:uint = input.readUnsignedShort();
			name = input.readUTFBytes(nameLen);
			level = input.readUnsignedInt();
			attack = input.readUnsignedInt();
			type = input.readUnsignedInt();
			dept = input.readUnsignedInt();
			phy_atk = input.readUnsignedInt();
			phy_def = input.readUnsignedInt();
			solar_atk = input.readUnsignedInt();
			solar_def = input.readUnsignedInt();
			hp_max = input.readUnsignedInt();
			mp_max = input.readUnsignedInt();
			add_hp = input.readUnsignedInt();
			add_mp = input.readUnsignedInt();
			hit = input.readUnsignedInt();
			dodge = input.readUnsignedInt();
			crit = input.readUnsignedInt();
			earth_atk = input.readUnsignedInt();
			earth_def = input.readUnsignedInt();
			water_atk = input.readUnsignedInt();
			water_def = input.readUnsignedInt();
			fire_atk = input.readUnsignedInt();
			fire_def = input.readUnsignedInt();
			wind_atk = input.readUnsignedInt();
			wind_def = input.readUnsignedInt();
			exp = input.readUnsignedInt();
			width = input.readUnsignedInt();
			height = input.readUnsignedInt();
			drop_id = input.readUnsignedInt();
			pet_id = input.readUnsignedInt();
			pet_ratio = input.readUnsignedInt();
			success_chance = input.readUnsignedInt();
			pet_catch_aging = input.readUnsignedInt();
			pet_catch_time = input.readUnsignedInt();
			pet_catch = input.readUnsignedInt();
			skill_ai_type = input.readUnsignedInt();
			use_type = input.readUnsignedInt();
			skill_ai_id = input.readUnsignedInt();
			ai_key = input.readUnsignedInt();
			use_once = input.readUnsignedInt();
			use_time = input.readUnsignedInt();
			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(monster_id);
			output.writeUnsignedInt(res_id);
			output.writeUnsignedInt(head_icon);
			var nameData:ByteArray = new ByteArray();
			nameData.writeUTFBytes(name);
			output.writeShort(nameData.length);
			output.writeBytes(nameData);
			output.writeUnsignedInt(level);
			output.writeUnsignedInt(attack);
			output.writeUnsignedInt(type);
			output.writeUnsignedInt(dept);
			output.writeUnsignedInt(phy_atk);
			output.writeUnsignedInt(phy_def);
			output.writeUnsignedInt(solar_atk);
			output.writeUnsignedInt(solar_def);
			output.writeUnsignedInt(hp_max);
			output.writeUnsignedInt(mp_max);
			output.writeUnsignedInt(add_hp);
			output.writeUnsignedInt(add_mp);
			output.writeUnsignedInt(hit);
			output.writeUnsignedInt(dodge);
			output.writeUnsignedInt(crit);
			output.writeUnsignedInt(earth_atk);
			output.writeUnsignedInt(earth_def);
			output.writeUnsignedInt(water_atk);
			output.writeUnsignedInt(water_def);
			output.writeUnsignedInt(fire_atk);
			output.writeUnsignedInt(fire_def);
			output.writeUnsignedInt(wind_atk);
			output.writeUnsignedInt(wind_def);
			output.writeUnsignedInt(exp);
			output.writeUnsignedInt(width);
			output.writeUnsignedInt(height);
			output.writeUnsignedInt(drop_id);
			output.writeUnsignedInt(pet_id);
			output.writeUnsignedInt(pet_ratio);
			output.writeUnsignedInt(success_chance);
			output.writeUnsignedInt(pet_catch_aging);
			output.writeUnsignedInt(pet_catch_time);
			output.writeUnsignedInt(pet_catch);
			output.writeUnsignedInt(skill_ai_type);
			output.writeUnsignedInt(use_type);
			output.writeUnsignedInt(skill_ai_id);
			output.writeUnsignedInt(ai_key);
			output.writeUnsignedInt(use_once);
			output.writeUnsignedInt(use_time);
			
		}
		
	}
}
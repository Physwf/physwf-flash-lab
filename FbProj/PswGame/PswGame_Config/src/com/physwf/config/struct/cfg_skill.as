package com.physwf.config.struct
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class cfg_skill implements IExternalizable
	{
		public var skill_id:uint;
		public var skill_name:String;
		public var skill_type:uint;
		public var role_type:uint;
		public var mouse:uint;
		public var strike:uint;
		public var is_auto_attack:uint;
		public var skill_lv:uint;
		public var user_lv:uint;
		public var mp_consumed:uint;
		public var hp_consumed:uint;
		public var sp_consumed:uint;
		public var chant_time:uint;
		public var chant_break:uint;
		public var actuation_time:uint;
		public var cd:uint;
		public var skill_des:String;
		public var atk_distance:uint;
		public var hit_area_type:uint;
		public var angle:uint;
		public var speed:uint;
		public var range_num:uint;
		public var weapon_damage:uint;
		public var pro_damage:uint;
		public var enmity_type:uint;
		public var enmity:uint;
		public var per_damage:uint;
		public var target_type:uint;
		public var skill_radius:uint;
		public var offset_x:uint;
		public var offset_y:uint;
		public var height:uint;
		public var width:uint;
		public var falldown:uint;
		public var effect_attack_id:uint;
		public var effect_hit_id:uint;
		public var buff_id:uint;
		public var invoke_skill_id:uint;
		public var invoke_skill_odds:uint;
		public var remote:uint;
		public var duration:uint;
		public var shareCD:uint;
		public var genius_id:uint;
		
		
		public function cfg_skill()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			skill_id = input.readUnsignedInt();
			var skill_nameLen:uint = input.readUnsignedShort();
			skill_name = input.readUTFBytes(skill_nameLen);
			skill_type = input.readUnsignedInt();
			role_type = input.readUnsignedInt();
			mouse = input.readUnsignedInt();
			strike = input.readUnsignedInt();
			is_auto_attack = input.readUnsignedInt();
			skill_lv = input.readUnsignedInt();
			user_lv = input.readUnsignedInt();
			mp_consumed = input.readUnsignedInt();
			hp_consumed = input.readUnsignedInt();
			sp_consumed = input.readUnsignedInt();
			chant_time = input.readUnsignedInt();
			chant_break = input.readUnsignedInt();
			actuation_time = input.readUnsignedInt();
			cd = input.readUnsignedInt();
			var skill_desLen:uint = input.readUnsignedShort();
			skill_des = input.readUTFBytes(skill_desLen);
			atk_distance = input.readUnsignedInt();
			hit_area_type = input.readUnsignedInt();
			angle = input.readUnsignedInt();
			speed = input.readUnsignedInt();
			range_num = input.readUnsignedInt();
			weapon_damage = input.readUnsignedInt();
			pro_damage = input.readUnsignedInt();
			enmity_type = input.readUnsignedInt();
			enmity = input.readUnsignedInt();
			per_damage = input.readUnsignedInt();
			target_type = input.readUnsignedInt();
			skill_radius = input.readUnsignedInt();
			offset_x = input.readUnsignedInt();
			offset_y = input.readUnsignedInt();
			height = input.readUnsignedInt();
			width = input.readUnsignedInt();
			falldown = input.readUnsignedInt();
			effect_attack_id = input.readUnsignedInt();
			effect_hit_id = input.readUnsignedInt();
			buff_id = input.readUnsignedInt();
			invoke_skill_id = input.readUnsignedInt();
			invoke_skill_odds = input.readUnsignedInt();
			remote = input.readUnsignedInt();
			duration = input.readUnsignedInt();
			shareCD = input.readUnsignedInt();
			genius_id = input.readUnsignedInt();
			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(skill_id);
			var skill_nameData:ByteArray = new ByteArray();
			skill_nameData.writeUTFBytes(skill_name);
			output.writeShort(skill_nameData.length);
			output.writeBytes(skill_nameData);
			output.writeUnsignedInt(skill_type);
			output.writeUnsignedInt(role_type);
			output.writeUnsignedInt(mouse);
			output.writeUnsignedInt(strike);
			output.writeUnsignedInt(is_auto_attack);
			output.writeUnsignedInt(skill_lv);
			output.writeUnsignedInt(user_lv);
			output.writeUnsignedInt(mp_consumed);
			output.writeUnsignedInt(hp_consumed);
			output.writeUnsignedInt(sp_consumed);
			output.writeUnsignedInt(chant_time);
			output.writeUnsignedInt(chant_break);
			output.writeUnsignedInt(actuation_time);
			output.writeUnsignedInt(cd);
			var skill_desData:ByteArray = new ByteArray();
			skill_desData.writeUTFBytes(skill_des);
			output.writeShort(skill_desData.length);
			output.writeBytes(skill_desData);
			output.writeUnsignedInt(atk_distance);
			output.writeUnsignedInt(hit_area_type);
			output.writeUnsignedInt(angle);
			output.writeUnsignedInt(speed);
			output.writeUnsignedInt(range_num);
			output.writeUnsignedInt(weapon_damage);
			output.writeUnsignedInt(pro_damage);
			output.writeUnsignedInt(enmity_type);
			output.writeUnsignedInt(enmity);
			output.writeUnsignedInt(per_damage);
			output.writeUnsignedInt(target_type);
			output.writeUnsignedInt(skill_radius);
			output.writeUnsignedInt(offset_x);
			output.writeUnsignedInt(offset_y);
			output.writeUnsignedInt(height);
			output.writeUnsignedInt(width);
			output.writeUnsignedInt(falldown);
			output.writeUnsignedInt(effect_attack_id);
			output.writeUnsignedInt(effect_hit_id);
			output.writeUnsignedInt(buff_id);
			output.writeUnsignedInt(invoke_skill_id);
			output.writeUnsignedInt(invoke_skill_odds);
			output.writeUnsignedInt(remote);
			output.writeUnsignedInt(duration);
			output.writeUnsignedInt(shareCD);
			output.writeUnsignedInt(genius_id);
			
		}
		
	}
}
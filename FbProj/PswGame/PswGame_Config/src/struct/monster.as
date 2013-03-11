package templates
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class monster implements IExternalizable
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
		public var height:uint;
		public var undefined:null;
		public var head_icon:uint;
		
		
		public function monster()
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
			height = input.readUnsignedByte();
			null
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
			output.writeByte(height);
			null
			output.writeByte(head_icon);
			
		}
		
	}
}
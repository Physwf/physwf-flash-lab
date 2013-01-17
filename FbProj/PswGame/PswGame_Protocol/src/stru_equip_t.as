package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_equip_t implements IExternalizable
	{
		public var instance_id:uint;
		public var equip_id:uint;
		public var strength:uint;
		public var magic:uint;
		public var physical:uint;
		public var genius:uint;
		public var agility:uint;
		public var hp:uint;
		public var mp:uint;
		public var atk:uint;
		public var def:uint;
		public var magic_atk:uint;
		public var magic_def:uint;
		public var crit_atk:uint;
		public var crit_def:uint;
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
		public var position:uint;
		
		public function stru_equip_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			instance_id = input.readUnsignedInt();
			equip_id = input.readUnsignedInt();
			strength = input.readUnsignedInt();
			magic = input.readUnsignedShort();
			physical = input.readUnsignedShort();
			genius = input.readUnsignedShort();
			agility = input.readUnsignedShort();
			hp = input.readUnsignedInt();
			mp = input.readUnsignedInt();
			atk = input.readUnsignedInt();
			def = input.readUnsignedInt();
			magic_atk = input.readUnsignedInt();
			magic_def = input.readUnsignedInt();
			crit_atk = input.readUnsignedShort();
			crit_def = input.readUnsignedInt();
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
			position = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(instance_id);
			output.writeInt(equip_id);
			output.writeInt(strength);
			output.writeShort(magic);
			output.writeShort(physical);
			output.writeShort(genius);
			output.writeShort(agility);
			output.writeInt(hp);
			output.writeInt(mp);
			output.writeInt(atk);
			output.writeInt(def);
			output.writeInt(magic_atk);
			output.writeInt(magic_def);
			output.writeShort(crit_atk);
			output.writeInt(crit_def);
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
			output.writeShort(position);			
		}
	}
}
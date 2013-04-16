package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class warrior_attr_t implements IExternalizable
	{
		public var hp_max:uint;
		public var mp_max:uint;
		public var phy_atk:uint;
		public var solar_atk:uint;
		public var phy_def:uint;
		public var solar_def:uint;
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
		
		public function warrior_attr_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			hp_max = input.readUnsignedInt();
			mp_max = input.readUnsignedInt();
			phy_atk = input.readUnsignedInt();
			solar_atk = input.readUnsignedInt();
			phy_def = input.readUnsignedInt();
			solar_def = input.readUnsignedInt();
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
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(hp_max);
			output.writeUnsignedInt(mp_max);
			output.writeUnsignedInt(phy_atk);
			output.writeUnsignedInt(solar_atk);
			output.writeUnsignedInt(phy_def);
			output.writeUnsignedInt(solar_def);
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
		}
	}
}
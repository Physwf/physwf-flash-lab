package com.physwf.config.struct
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class cfg_player implements IExternalizable
	{
		public var num:uint;
		public var role_type:uint;
		public var Lv:uint;
		public var exp:uint;
		public var hp_max:uint;
		public var mp_max:uint;
		public var strength:uint;
		public var solar:uint;
		public var physique:uint;
		public var spirit:uint;
		public var agility:uint;
		public var phy_atk:uint;
		public var solar_atk:uint;
		public var phy_def:uint;
		public var solar_def:uint;
		public var hit:uint;
		public var dodge:uint;
		public var crit:uint;
		
		
		public function cfg_player()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			num = input.readUnsignedInt();
			role_type = input.readUnsignedInt();
			Lv = input.readUnsignedInt();
			exp = input.readUnsignedInt();
			hp_max = input.readUnsignedInt();
			mp_max = input.readUnsignedInt();
			strength = input.readUnsignedInt();
			solar = input.readUnsignedInt();
			physique = input.readUnsignedInt();
			spirit = input.readUnsignedInt();
			agility = input.readUnsignedInt();
			phy_atk = input.readUnsignedInt();
			solar_atk = input.readUnsignedInt();
			phy_def = input.readUnsignedInt();
			solar_def = input.readUnsignedInt();
			hit = input.readUnsignedInt();
			dodge = input.readUnsignedInt();
			crit = input.readUnsignedInt();
			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(num);
			output.writeUnsignedInt(role_type);
			output.writeUnsignedInt(Lv);
			output.writeUnsignedInt(exp);
			output.writeUnsignedInt(hp_max);
			output.writeUnsignedInt(mp_max);
			output.writeUnsignedInt(strength);
			output.writeUnsignedInt(solar);
			output.writeUnsignedInt(physique);
			output.writeUnsignedInt(spirit);
			output.writeUnsignedInt(agility);
			output.writeUnsignedInt(phy_atk);
			output.writeUnsignedInt(solar_atk);
			output.writeUnsignedInt(phy_def);
			output.writeUnsignedInt(solar_def);
			output.writeUnsignedInt(hit);
			output.writeUnsignedInt(dodge);
			output.writeUnsignedInt(crit);
			
		}
		
	}
}
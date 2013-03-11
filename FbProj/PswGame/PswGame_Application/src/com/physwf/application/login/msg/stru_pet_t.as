package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_pet_t implements IExternalizable
	{
		public var instance_id:uint;
		public var pet_id:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var level:uint;
		public var exp:uint;
		public var hp:uint;
		public var mp:uint;
		public var happiness:uint;
		public var life:uint;
		public var sex:uint;
		public var charactor:uint;
		public var strength:uint;
		public var solar:uint;
		public var physique:uint;
		public var spirit:uint;
		public var agility:uint;
		public var stren_talent:uint;
		public var solar_talent:uint;
		public var physique_talent:uint;
		public var spirit_talent:uint;
		public var agility_talent:uint;
		public var phy_atk:uint;
		public var solar_atk:uint;
		public var phy_def:uint;
		public var solar_def:uint;
		public var crit:uint;
		public var crit_damage:uint;
		public var crit_tenacity:uint;
		public var hit:uint;
		public var dodge:uint;
		
		public function stru_pet_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			instance_id = input.readUnsignedInt();
			pet_id = input.readUnsignedInt();
			nick = input.readUTFBytes(16);
			level = input.readUnsignedShort();
			exp = input.readUnsignedInt();
			hp = input.readUnsignedInt();
			mp = input.readUnsignedInt();
			happiness = input.readUnsignedShort();
			life = input.readUnsignedShort();
			sex = input.readUnsignedByte();
			charactor = input.readUnsignedByte();
			strength = input.readUnsignedShort();
			solar = input.readUnsignedShort();
			physique = input.readUnsignedShort();
			spirit = input.readUnsignedShort();
			agility = input.readUnsignedShort();
			stren_talent = input.readUnsignedShort();
			solar_talent = input.readUnsignedShort();
			physique_talent = input.readUnsignedShort();
			spirit_talent = input.readUnsignedShort();
			agility_talent = input.readUnsignedShort();
			phy_atk = input.readUnsignedInt();
			solar_atk = input.readUnsignedInt();
			phy_def = input.readUnsignedInt();
			solar_def = input.readUnsignedInt();
			crit = input.readUnsignedByte();
			crit_damage = input.readUnsignedByte();
			crit_tenacity = input.readUnsignedByte();
			hit = input.readUnsignedShort();
			dodge = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(instance_id);
			output.writeUnsignedInt(pet_id);
			if(nick_data)
			{
				output.writeBytes(nick_data)
			}
			else
			{
				var nickData:ByteArray = new ByteArray();
				nickData.writeUTFBytes(nick)
				nickData.length = 16;
				output.writeBytes(nickData)
			}
			output.writeShort(level);
			output.writeUnsignedInt(exp);
			output.writeUnsignedInt(hp);
			output.writeUnsignedInt(mp);
			output.writeShort(happiness);
			output.writeShort(life);
			output.writeByte(sex);
			output.writeByte(charactor);
			output.writeShort(strength);
			output.writeShort(solar);
			output.writeShort(physique);
			output.writeShort(spirit);
			output.writeShort(agility);
			output.writeShort(stren_talent);
			output.writeShort(solar_talent);
			output.writeShort(physique_talent);
			output.writeShort(spirit_talent);
			output.writeShort(agility_talent);
			output.writeUnsignedInt(phy_atk);
			output.writeUnsignedInt(solar_atk);
			output.writeUnsignedInt(phy_def);
			output.writeUnsignedInt(solar_def);
			output.writeByte(crit);
			output.writeByte(crit_damage);
			output.writeByte(crit_tenacity);
			output.writeShort(hit);
			output.writeShort(dodge);			
		}
	}
}
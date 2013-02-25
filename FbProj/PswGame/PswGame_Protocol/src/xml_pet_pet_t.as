package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_pet_pet_t implements IExternalizable
	{
		public var pet_id:uint;
		public var level:uint;
		public var uselv:uint;
		public var lifetime:uint;
		public var type:uint;
		public var breed:uint;
		public var move_speed:uint;
		public var atk_speed:uint;
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
		public var atk:uint;
		public var def:uint;
		public var magic_atk:uint;
		public var magic_def:uint;
		public var crit:uint;
		public var crit_damage:uint;
		public var crit_tenacity:uint;
		public var hit:uint;
		public var dodge:uint;
		
		public function xml_pet_pet_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			pet_id = input.readUnsignedShort();
			level = input.readUnsignedShort();
			uselv = input.readUnsignedShort();
			lifetime = input.readUnsignedInt();
			type = input.readUnsignedShort();
			breed = input.readUnsignedShort();
			move_speed = input.readUnsignedShort();
			atk_speed = input.readUnsignedShort();
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
			atk = input.readUnsignedShort();
			def = input.readUnsignedShort();
			magic_atk = input.readUnsignedShort();
			magic_def = input.readUnsignedShort();
			crit = input.readUnsignedByte();
			crit_damage = input.readUnsignedByte();
			crit_tenacity = input.readUnsignedByte();
			hit = input.readUnsignedShort();
			dodge = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(pet_id);
			output.writeShort(level);
			output.writeShort(uselv);
			output.writeUnsignedInt(lifetime);
			output.writeShort(type);
			output.writeShort(breed);
			output.writeShort(move_speed);
			output.writeShort(atk_speed);
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
			output.writeShort(atk);
			output.writeShort(def);
			output.writeShort(magic_atk);
			output.writeShort(magic_def);
			output.writeByte(crit);
			output.writeByte(crit_damage);
			output.writeByte(crit_tenacity);
			output.writeShort(hit);
			output.writeShort(dodge);			
		}
	}
}
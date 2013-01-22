package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class xml_pet_item_t implements IExternalizable
	{
		public var id:uint;
		public var level:uint;
		public var uselv:uint;
		public var lifetime:uint;
		public var type:uint;
		public var breed:uint;
		public var move_speed:uint;
		public var atk_speed:uint;
		public var strength:uint;
		public var magic:uint;
		public var physique:uint;
		public var spell:uint;
		public var mind:uint;
		public var stren_talent:uint;
		public var magic_talent:uint;
		public var physique_talent:uint;
		public var spell_talent:uint;
		public var mind_talent:uint;
		public var atk:uint;
		public var def:uint;
		public var magic_atk:uint;
		public var magic_def:uint;
		public var crit_atk:uint;
		public var crit_def:uint;
		public var hit:uint;
		public var dodge:uint;
		
		public function xml_pet_item_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			level = input.readUnsignedShort();
			uselv = input.readUnsignedShort();
			lifetime = input.readUnsignedInt();
			type = input.readUnsignedShort();
			breed = input.readUnsignedShort();
			move_speed = input.readUnsignedShort();
			atk_speed = input.readUnsignedShort();
			strength = input.readUnsignedShort();
			magic = input.readUnsignedShort();
			physique = input.readUnsignedShort();
			spell = input.readUnsignedShort();
			mind = input.readUnsignedShort();
			stren_talent = input.readUnsignedShort();
			magic_talent = input.readUnsignedShort();
			physique_talent = input.readUnsignedShort();
			spell_talent = input.readUnsignedShort();
			mind_talent = input.readUnsignedShort();
			atk = input.readUnsignedInt();
			def = input.readUnsignedInt();
			magic_atk = input.readUnsignedInt();
			magic_def = input.readUnsignedInt();
			crit_atk = input.readUnsignedShort();
			crit_def = input.readUnsignedShort();
			hit = input.readUnsignedShort();
			dodge = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(id);
			output.writeShort(level);
			output.writeShort(uselv);
			output.writeUnsignedInt(lifetime);
			output.writeShort(type);
			output.writeShort(breed);
			output.writeShort(move_speed);
			output.writeShort(atk_speed);
			output.writeShort(strength);
			output.writeShort(magic);
			output.writeShort(physique);
			output.writeShort(spell);
			output.writeShort(mind);
			output.writeShort(stren_talent);
			output.writeShort(magic_talent);
			output.writeShort(physique_talent);
			output.writeShort(spell_talent);
			output.writeShort(mind_talent);
			output.writeUnsignedInt(atk);
			output.writeUnsignedInt(def);
			output.writeUnsignedInt(magic_atk);
			output.writeUnsignedInt(magic_def);
			output.writeShort(crit_atk);
			output.writeShort(crit_def);
			output.writeShort(hit);
			output.writeShort(dodge);			
		}
	}
}
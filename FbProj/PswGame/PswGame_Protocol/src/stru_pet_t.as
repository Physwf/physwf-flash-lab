package 
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
		public var character:uint;
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
			character = input.readUnsignedByte();
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
			output.writeByte(character);
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
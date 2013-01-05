package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_pet_t implements IExternalizable
	{
		public var pet_id:uint;
		public var pet_type:uint;
		public var nick:String;
		public var level:uint;
		public var exp:uint;
		public var hp:uint;
		public var mp:uint;
		public var happiness:uint;
		public var life:uint;
		public var sex:uint;
		public var character:uint;
		public var strength:uint;
		public var intelligence:uint;
		public var physical:uint;
		public var magic:uint;
		public var speed:uint;
		public var additions:uint;
		public var strength_factor:uint;
		public var intelligence_factor:uint;
		public var physical_factor:uint;
		public var magic_factor:uint;
		public var speed_factor:uint;
		public var hp_max:uint;
		public var mp_max:uint;
		public var attack:uint;
		public var mattack:uint;
		public var defense:uint;
		public var mdefense:uint;
		public var hit:uint;
		public var avoid:uint;
		public var multi_atk:uint;
		public var multi_atk_avoid:uint;
		
		public function stru_pet_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			pet_id = input.readUnsignedInt();
			pet_type = input.readUnsignedInt();
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
			intelligence = input.readUnsignedShort();
			physical = input.readUnsignedShort();
			magic = input.readUnsignedShort();
			speed = input.readUnsignedShort();
			additions = input.readUnsignedShort();
			strength_factor = input.readUnsignedShort();
			intelligence_factor = input.readUnsignedShort();
			physical_factor = input.readUnsignedShort();
			magic_factor = input.readUnsignedShort();
			speed_factor = input.readUnsignedShort();
			hp_max = input.readUnsignedInt();
			mp_max = input.readUnsignedInt();
			attack = input.readUnsignedInt();
			mattack = input.readUnsignedInt();
			defense = input.readUnsignedInt();
			mdefense = input.readUnsignedInt();
			hit = input.readUnsignedShort();
			avoid = input.readUnsignedShort();
			multi_atk = input.readUnsignedShort();
			multi_atk_avoid = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(pet_id);
			output.writeInt(pet_type);
			var nickData:ByteArray = new ByteArray();
			nickData.writeUTFBytes(nick)
			nickData.length = 16;
			output.writeBytes(nickData)
			output.writeShort(level);
			output.writeInt(exp);
			output.writeInt(hp);
			output.writeInt(mp);
			output.writeShort(happiness);
			output.writeShort(life);
			output.writeByte(sex);
			output.writeByte(character);
			output.writeShort(strength);
			output.writeShort(intelligence);
			output.writeShort(physical);
			output.writeShort(magic);
			output.writeShort(speed);
			output.writeShort(additions);
			output.writeShort(strength_factor);
			output.writeShort(intelligence_factor);
			output.writeShort(physical_factor);
			output.writeShort(magic_factor);
			output.writeShort(speed_factor);
			output.writeInt(hp_max);
			output.writeInt(mp_max);
			output.writeInt(attack);
			output.writeInt(mattack);
			output.writeInt(defense);
			output.writeInt(mdefense);
			output.writeShort(hit);
			output.writeShort(avoid);
			output.writeShort(multi_atk);
			output.writeShort(multi_atk_avoid);			
		}
	}
}
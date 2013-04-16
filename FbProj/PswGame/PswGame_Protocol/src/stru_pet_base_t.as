package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_pet_base_t implements IExternalizable
	{
		public var instance_id:uint;
		public var pet_id:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var level:uint;
		public var exp:uint;
		public var hp:uint;
		public var mp:uint;
		public var growth_rate:uint;
		public var charactor:uint;
		public var stren_talent:uint;
		public var solar_talent:uint;
		public var physique_talent:uint;
		public var spirit_talent:uint;
		public var agility_talent:uint;
		public var skills:stru_skill_v;
		
		public function stru_pet_base_t()
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
			growth_rate = input.readUnsignedShort();
			charactor = input.readUnsignedByte();
			stren_talent = input.readUnsignedShort();
			solar_talent = input.readUnsignedShort();
			physique_talent = input.readUnsignedShort();
			spirit_talent = input.readUnsignedShort();
			agility_talent = input.readUnsignedShort();
			skills= new stru_skill_v();
			skills.readExternal(input)			
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
			output.writeShort(growth_rate);
			output.writeByte(charactor);
			output.writeShort(stren_talent);
			output.writeShort(solar_talent);
			output.writeShort(physique_talent);
			output.writeShort(spirit_talent);
			output.writeShort(agility_talent);
			skills.writeExternal(output)			
		}
	}
}
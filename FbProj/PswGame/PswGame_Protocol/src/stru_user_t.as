package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_user_t implements IExternalizable
	{
		public var nick:String;
		public var nick_data:ByteArray
		public var prof:uint;
		public var sex:uint;
		public var level:uint;
		public var exp:uint;
		public var map_id:uint;
		public var map_x:uint;
		public var map_y:uint;
		public var hp:uint;
		public var mp:uint;
		public var sp:uint;
		public var hp_max:uint;
		public var mp_max:uint;
		public var strength:uint;
		public var solar:uint;
		public var physique:uint;
		public var spirit:uint;
		public var agility:uint;
		public var warrior_attr:warriro_attr_t;
		public var vigour:uint;
		public var energy:uint;
		
		public function stru_user_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			nick = input.readUTFBytes(16);
			prof = input.readUnsignedByte();
			sex = input.readUnsignedByte();
			level = input.readUnsignedShort();
			exp = input.readUnsignedInt();
			map_id = input.readUnsignedInt();
			map_x = input.readUnsignedShort();
			map_y = input.readUnsignedShort();
			hp = input.readUnsignedInt();
			mp = input.readUnsignedInt();
			sp = input.readUnsignedShort();
			hp_max = input.readUnsignedInt();
			mp_max = input.readUnsignedInt();
			strength = input.readUnsignedShort();
			solar = input.readUnsignedShort();
			physique = input.readUnsignedShort();
			spirit = input.readUnsignedShort();
			agility = input.readUnsignedShort();
			warrior_attr= new warriro_attr_t();
			warrior_attr.readExternal(input)
			vigour = input.readUnsignedShort();
			energy = input.readUnsignedShort();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
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
			output.writeByte(prof);
			output.writeByte(sex);
			output.writeShort(level);
			output.writeUnsignedInt(exp);
			output.writeUnsignedInt(map_id);
			output.writeShort(map_x);
			output.writeShort(map_y);
			output.writeUnsignedInt(hp);
			output.writeUnsignedInt(mp);
			output.writeShort(sp);
			output.writeUnsignedInt(hp_max);
			output.writeUnsignedInt(mp_max);
			output.writeShort(strength);
			output.writeShort(solar);
			output.writeShort(physique);
			output.writeShort(spirit);
			output.writeShort(agility);
			warrior_attr.writeExternal(output)
			output.writeShort(vigour);
			output.writeShort(energy);			
		}
	}
}
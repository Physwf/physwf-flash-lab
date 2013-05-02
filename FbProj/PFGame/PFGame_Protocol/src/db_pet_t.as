package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_pet_t implements IExternalizable
	{
		public var id:uint;
		public var key:uint;
		public var step:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var btl_idx:uint;
		public var exp:uint;
		public var character:uint;
		public var power_grow:uint;
		public var stamina_grow:uint;
		public var magic_grow:uint;
		public var speed_grow:uint;
		public var def_skill_exp:uint;
		public var pet_skill_1:uint;
		public var pet_skill_2:uint;
		public var pet_skill_3:uint;
		
		public function db_pet_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			id = input.readUnsignedInt();
			key = input.readUnsignedInt();
			step = input.readUnsignedByte();
			nick = input.readUTF();
			btl_idx = input.readUnsignedByte();
			exp = input.readUnsignedInt();
			character = input.readUnsignedByte();
			power_grow = input.readUnsignedShort();
			stamina_grow = input.readUnsignedShort();
			magic_grow = input.readUnsignedShort();
			speed_grow = input.readUnsignedShort();
			def_skill_exp = input.readUnsignedInt();
			pet_skill_1 = input.readUnsignedInt();
			pet_skill_2 = input.readUnsignedInt();
			pet_skill_3 = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(id);
			output.writeUnsignedInt(key);
			output.writeByte(step);
			output.writeUTF(nick);
			output.writeByte(btl_idx);
			output.writeUnsignedInt(exp);
			output.writeByte(character);
			output.writeShort(power_grow);
			output.writeShort(stamina_grow);
			output.writeShort(magic_grow);
			output.writeShort(speed_grow);
			output.writeUnsignedInt(def_skill_exp);
			output.writeUnsignedInt(pet_skill_1);
			output.writeUnsignedInt(pet_skill_2);
			output.writeUnsignedInt(pet_skill_3);			
		}
	}
}
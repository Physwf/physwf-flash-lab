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
		public var role_sex:uint;
		public var level:uint;
		public var exp:uint;
		public var map_id:uint;
		public var map_x:uint;
		public var map_y:uint;
		public var hp:uint;
		public var mp:uint;
		public var sp:uint;
		public var vigour:uint;
		public var energy:uint;
		
		public function stru_user_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			nick = input.readUTFBytes(16);
			prof = input.readUnsignedByte();
			role_sex = input.readUnsignedByte();
			level = input.readUnsignedShort();
			exp = input.readUnsignedInt();
			map_id = input.readUnsignedInt();
			map_x = input.readUnsignedShort();
			map_y = input.readUnsignedShort();
			hp = input.readUnsignedInt();
			mp = input.readUnsignedInt();
			sp = input.readUnsignedShort();
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
			output.writeByte(role_sex);
			output.writeShort(level);
			output.writeUnsignedInt(exp);
			output.writeUnsignedInt(map_id);
			output.writeShort(map_x);
			output.writeShort(map_y);
			output.writeUnsignedInt(hp);
			output.writeUnsignedInt(mp);
			output.writeShort(sp);
			output.writeShort(vigour);
			output.writeShort(energy);			
		}
	}
}
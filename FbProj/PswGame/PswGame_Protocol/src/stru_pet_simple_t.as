package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class stru_pet_simple_t implements IExternalizable
	{
		public var pet_id:uint;
		public var pet_type:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var level:uint;
		public var hp:uint;
		public var mp:uint;
		
		public function stru_pet_simple_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			pet_id = input.readUnsignedInt();
			pet_type = input.readUnsignedInt();
			nick = input.readUTFBytes(16);
			level = input.readUnsignedShort();
			hp = input.readUnsignedInt();
			mp = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(pet_id);
			output.writeInt(pet_type);
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
			output.writeInt(hp);
			output.writeInt(mp);			
		}
	}
}
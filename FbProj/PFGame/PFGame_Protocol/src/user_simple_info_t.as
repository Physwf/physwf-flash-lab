package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class user_simple_info_t implements IExternalizable
	{
		public var uid:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var sex:uint;
		public var world_id:uint;
		
		public function user_simple_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			uid = input.readUnsignedInt();
			nick = input.readUTF();
			sex = input.readUnsignedByte();
			world_id = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);
			output.writeUTF(nick);
			output.writeByte(sex);
			output.writeUnsignedInt(world_id);			
		}
	}
}
package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class user_info_t implements IExternalizable
	{
		public var nick:String;
		public var nick_data:ByteArray
		public var sex:uint;
		public var map_id:uint;
		
		public function user_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			nick = input.readUTF();
			sex = input.readUnsignedByte();
			map_id = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUTF(nick);
			output.writeByte(sex);
			output.writeUnsignedInt(map_id);			
		}
	}
}
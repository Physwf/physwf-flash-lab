package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class world_user_map_show_info_t implements IExternalizable
	{
		public var uid:uint;
		public var nick:String;
		public var nick_data:ByteArray
		public var sex:uint;
		public var attire:uint;
		public var pos:world_user_pos_t;
		
		public function world_user_map_show_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			uid = input.readUnsignedInt();
			nick = input.readUTF();
			sex = input.readUnsignedByte();
			attire = input.readUnsignedInt();
			pos= new world_user_pos_t();
			pos.readExternal(input)			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);
			output.writeUTF(nick);
			output.writeByte(sex);
			output.writeUnsignedInt(attire);
			pos.writeExternal(output)			
		}
	}
}
package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class offline_db_info_t implements IExternalizable
	{
		public var type:uint;
		public var uid:uint;
		public var nick:String;
		public var nick_data:ByteArray
		
		public function offline_db_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			type = input.readUnsignedInt();
			uid = input.readUnsignedInt();
			nick = input.readUTF();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(type);
			output.writeUnsignedInt(uid);
			output.writeUTF(nick);			
		}
	}
}
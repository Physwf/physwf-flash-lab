package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_msg_t implements IExternalizable
	{
		public var sn:uint;
		public var type:uint;
		public var msg:String;
		public var msg_data:ByteArray
		public var expire_time:uint;
		
		public function db_msg_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			sn = input.readUnsignedInt();
			type = input.readUnsignedByte();
			msg = input.readUTF();
			expire_time = input.readUnsignedInt();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(sn);
			output.writeByte(type);
			output.writeUTF(msg);
			output.writeUnsignedInt(expire_time);			
		}
	}
}
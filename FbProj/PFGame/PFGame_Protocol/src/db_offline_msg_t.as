package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class db_offline_msg_t implements IExternalizable
	{
		public var sn:uint;
		public var msg:String;
		public var msg_data:ByteArray
		
		public function db_offline_msg_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			sn = input.readUnsignedInt();
			msg = input.readUTF();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(sn);
			output.writeUTF(msg);			
		}
	}
}
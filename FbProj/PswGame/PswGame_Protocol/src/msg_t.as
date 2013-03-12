package 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class msg_t implements IExternalizable
	{
		public var msg:String;
		public var msg_data:ByteArray
		
		public function msg_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			var msgLen:uint =input.readUnsignedInt();
			msg=input.readUTFBytes(msgLen);			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeUnsignedInt(msg.length);
			output.writeUTFBytes(msg);			
		}
	}
}
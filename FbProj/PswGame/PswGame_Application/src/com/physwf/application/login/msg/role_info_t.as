package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.utils.ByteArray;
	
	public class role_info_t implements IExternalizable
	{
		public var role_tm:uint;
		public var nick:String;
		public var prof:uint;
		
		public function role_info_t()
		{
		}
		
		public function readExternal(input:IDataInput):void
		{
			role_tm = input.readUnsignedInt();
			nick = input.readUTFBytes(16);
			prof = input.readUnsignedByte();			
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeInt(role_tm);
			var nickData:ByteArray = new ByteArray();
			nickData.writeUTFBytes(nick)
			nickData.length = 16;
			output.writeBytes(nickData)
			output.writeByte(prof);			
		}
	}
}
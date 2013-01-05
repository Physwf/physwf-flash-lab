package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_CREATE_ROLE_107 extends MsgBase
	{
		public var area_id:uint;
		public var nick:String;
		public var prof:uint;
		public var channel:uint;
		public var session:String;
		public var tad:String;
		
		public function MSG_REQ_CREATE_ROLE_107()
		{
			super(107)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(area_id);
			var nickData:ByteArray = new ByteArray();
			nickData.writeUTFBytes(nick)
			nickData.length = 16;
			output.writeBytes(nickData)
			output.writeByte(prof);
			output.writeInt(channel);
			var sessionData:ByteArray = new ByteArray();
			sessionData.writeUTFBytes(session)
			sessionData.length = 16;
			output.writeBytes(sessionData)
			output.writeUnsignedInt(tad.length);
			output.writeUTFBytes(tad);			
		}
	}
}
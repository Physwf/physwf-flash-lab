package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_ROLE_INFO_106 extends MsgBase
	{
		public var area_id:uint;
		public var session:String;
		public var tad:String;
		
		public function MSG_REQ_GET_ROLE_INFO_106()
		{
			super(106)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(area_id);
			var sessionData:ByteArray = new ByteArray();
			sessionData.writeUTFBytes(session)
			sessionData.length = 16;
			output.writeBytes(sessionData)
			var tadData:ByteArray = new ByteArray();
//			tadData.writeUTFBytes(tad)
			tadData.length = 128;
			output.writeBytes(tadData)			
		}
	}
}
package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_ROLE_INFO_106 extends MsgBase
	{
		public var area_id:uint;
		public var session:String;
		public var session_data:ByteArray
		public var tad:String;
		public var tad_data:ByteArray
		
		public function MSG_REQ_GET_ROLE_INFO_106()
		{
			super(106)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeShort(area_id);
			if(session_data)
			{
				output.writeBytes(session_data)
			}
			else
			{
				var sessionData:ByteArray = new ByteArray();
				sessionData.writeUTFBytes(session)
				sessionData.length = 16;
				output.writeBytes(sessionData)
			}
			if(tad_data)
			{
				output.writeBytes(tad_data)
			}
			else
			{
				var tadData:ByteArray = new ByteArray();
				tadData.writeUTFBytes(tad)
				tadData.length = 128;
				output.writeBytes(tadData)
			}			
		}
	}
}
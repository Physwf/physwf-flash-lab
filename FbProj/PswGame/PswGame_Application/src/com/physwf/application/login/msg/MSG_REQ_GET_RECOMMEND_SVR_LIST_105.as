package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_RECOMMEND_SVR_LIST_105 extends MsgBase
	{
		public var session:String;
		public var session_data:ByteArray
		public var tad:String;
		public var tad_data:ByteArray
		
		public function MSG_REQ_GET_RECOMMEND_SVR_LIST_105()
		{
			super(105)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
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
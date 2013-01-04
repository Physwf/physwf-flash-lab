package com.physwf.application.login.msg
{
	import 
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_GET_RECOMMEND_SVR_LIST_105 extends MsgBase
	{
		public var session:String;
		public var tad:String;
		
		public function MSG_REQ_GET_RECOMMEND_SVR_LIST_105()
		{
			super(105)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			var sessionData:ByteArray = new ByteArray();
			sessionData.writeUTFBytes(session)
			sessionData.length = 16;
			output.writeBytes(sessionData)
			var tadData:ByteArray = new ByteArray();
			tadData.writeUTFBytes(tad)
			tadData.length = 128;
			output.writeBytes(tadData)			
		}
	}
}
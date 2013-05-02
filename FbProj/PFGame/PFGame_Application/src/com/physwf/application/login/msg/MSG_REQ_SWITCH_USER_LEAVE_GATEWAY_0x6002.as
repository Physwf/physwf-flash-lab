package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SWITCH_USER_LEAVE_GATEWAY_0x6002 extends MsgBase
	{
		
		public function MSG_REQ_SWITCH_USER_LEAVE_GATEWAY_0x6002()
		{
			super(0x6002)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
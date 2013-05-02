package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_ROLE_EXIST_ROLE_0x9001 extends MsgBase
	{
		
		public function MSG_REQ_ROLE_EXIST_ROLE_0x9001()
		{
			super(0x9001)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			
		}
	}
}
package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SWITCH_USER_VERIFY_DONE_0x6001 extends MsgBase
	{
		public var t_user:uint;
		
		public function MSG_RES_SWITCH_USER_VERIFY_DONE_0x6001(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			t_user = input.readUnsignedInt();			
		}
	}
}
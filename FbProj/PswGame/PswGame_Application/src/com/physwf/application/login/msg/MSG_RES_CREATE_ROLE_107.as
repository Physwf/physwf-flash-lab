package com.physwf.application.login.msg
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_CREATE_ROLE_107 extends MsgBase
	{
		public var role_tm:uint;
		
		public function MSG_RES_CREATE_ROLE_107(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			role_tm = input.readUnsignedInt();			
		}
	}
}
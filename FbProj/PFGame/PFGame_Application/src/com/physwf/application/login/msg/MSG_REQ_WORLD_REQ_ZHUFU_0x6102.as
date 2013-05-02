package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_REQ_ZHUFU_0x6102 extends MsgBase
	{
		public var user_info:base_user_info_t;
		
		public function MSG_REQ_WORLD_REQ_ZHUFU_0x6102()
		{
			super(0x6102)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			user_info.writeExternal(output)			
		}
	}
}
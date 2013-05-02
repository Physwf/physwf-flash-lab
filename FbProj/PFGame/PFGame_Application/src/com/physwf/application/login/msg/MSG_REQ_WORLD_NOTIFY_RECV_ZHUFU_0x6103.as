package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_WORLD_NOTIFY_RECV_ZHUFU_0x6103 extends MsgBase
	{
		public var uid:uint;
		
		public function MSG_REQ_WORLD_NOTIFY_RECV_ZHUFU_0x6103()
		{
			super(0x6103)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uid);			
		}
	}
}
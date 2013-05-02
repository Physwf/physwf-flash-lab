package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SWITCH_GET_WORLD_LIST_0x6004 extends MsgBase
	{
		public var page:uint;
		
		public function MSG_REQ_SWITCH_GET_WORLD_LIST_0x6004()
		{
			super(0x6004)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(page);			
		}
	}
}
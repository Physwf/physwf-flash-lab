package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_WORLD_REQ_FRIEND_SIMPLE_INFO_0x6100 extends MsgBase
	{
		public var online:uint;
		public var uid:uint;
		
		public function MSG_RES_WORLD_REQ_FRIEND_SIMPLE_INFO_0x6100(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			online = input.readUnsignedByte();
			uid = input.readUnsignedInt();			
		}
	}
}
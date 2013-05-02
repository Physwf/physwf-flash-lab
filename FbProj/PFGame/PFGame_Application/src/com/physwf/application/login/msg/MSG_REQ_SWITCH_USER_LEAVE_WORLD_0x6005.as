package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_SWITCH_USER_LEAVE_WORLD_0x6005 extends MsgBase
	{
		public var uids:Vector.<uint>;
		
		public function MSG_REQ_SWITCH_USER_LEAVE_WORLD_0x6005()
		{
			super(0x6005)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUnsignedInt(uids.length);
			for(var i:uint=0;i<uids.length;i++)
			{
				output.writeUnsignedInt(uids[i]);
			}			
		}
	}
}
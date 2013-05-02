package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_REQ_LOGIN_VERIFY_USER_0x0001 extends MsgBase
	{
		public var user_name:String;
		public var user_name_data:ByteArray
		public var pw:String;
		public var pw_data:ByteArray
		public var from_site:String;
		public var from_site_data:ByteArray
		public var game_area:uint;
		
		public function MSG_REQ_LOGIN_VERIFY_USER_0x0001()
		{
			super(0x0001)
		}
		
		override protected function writeBody(output:IDataOutput):void
		{
			output.writeUTF(user_name);
			output.writeUTF(pw);
			output.writeUTF(from_site);
			output.writeUnsignedInt(game_area);			
		}
	}
}
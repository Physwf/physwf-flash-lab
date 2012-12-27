package com.physwf.application.login.msg
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;

	public class MSG_RES_LOGIN_103 extends MsgBase
	{
		public var login_result:int;
		public var session:ByteArray;
		public var has_role:Boolean;
		
		public var img_id:ByteArray;
		public var img_size:uint;
		public var img_data:ByteArray;
		
		public function MSG_RES_LOGIN_103(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			login_result = input.readUnsignedInt();
			
			if(login_result==0)
			{
				session = new ByteArray();
				input.readBytes(session, 0, 16);
				has_role = (input.readUnsignedInt() > 0);
			}
			else if(login_result<6)
			{
				img_id = new ByteArray();
				input.readBytes(img_id, 0, 16);
				img_size = input.readUnsignedInt();
				img_data = new ByteArray();
				input.readBytes(img_data, 0, img_size);
			}
			else
			{
				
			}
		}
	}
}
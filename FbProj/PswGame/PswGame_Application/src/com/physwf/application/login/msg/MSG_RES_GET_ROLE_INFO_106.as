package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_ROLE_INFO_106 extends MsgBase
	{
		public var userid:uint;
		public var roles:Vector.<role_detail_info>;
		
		public function MSG_RES_GET_ROLE_INFO_106(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			userid = input.readUnsignedInt();
			var rolesLen:uint =input.readUnsignedInt();
			roles= new Vector.<role_detail_info>();
			for(var i:int=0;i<rolesLen;++i)
			{
				var roles_item:role_detail_info = new role_detail_info()
				roles_item.readExternal(input);;
				roles.push(roles_item);
			}			
		}
	}
}
package com.physwf.application.login.msg
{
	import 
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_ROLE_INFO_106 extends MsgBase
	{
		public var userid:uint;
		public var roles:Vector.<role_info_t>;
		
		public function MSG_RES_GET_ROLE_INFO_106(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			userid = input.readUnsignedInt();
			var rolesLen:uint =input.readUnsignedInt();
			roles= new Vector.<role_info_t>();
			for(var i:int=0;i<rolesLen;++i)
			{
				var item:role_info_t = new role_info_t()
				item.readExternal(input);;
				roles.push(item);
			}			
		}
	}
}
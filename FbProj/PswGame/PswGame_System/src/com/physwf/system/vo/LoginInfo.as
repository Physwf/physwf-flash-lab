package com.physwf.system.vo
{
	import flash.utils.ByteArray;

	public class LoginInfo
	{
		public var userID:String;
		public var password:String;
		
		public var which_game:int;
		
		public var host:String;
		public var port:uint;
		
		public var session:ByteArray;
		
		public var tad:String;
		/**
		 *所登录的服务器信息 
		 */		
		public var serverInfo:ServerInfo;
		/**
		 *所选择的角色信息 
		 */		
		public var roleInfo:RoleInfo;
		
		public function LoginInfo()
		{
		}
	}
}
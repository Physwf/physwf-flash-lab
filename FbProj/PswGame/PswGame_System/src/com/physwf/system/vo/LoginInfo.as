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
		
		public function LoginInfo()
		{
		}
	}
}
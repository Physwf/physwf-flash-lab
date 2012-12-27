package com.physwf.application.login.cache
{
	public class LoginContext
	{
		private static var mChannel:int;
		private static var mProductID:int;
		private static var mProductName:String;
		
		private static var mUserIP:String;
		private static var mTag:*;
		
		private static var mImgID:String;
		private static var mVerifyCode:String;
		
		public function LoginContext()
		{
		}
		
		public static function initialize():void
		{
			mChannel=0;
		}
		
		public static function setProductInfo(pid:String,pName:String):void
		{
			mProductID = uint(pid);
			mProductName = pName;
		}
		
		public static function get channel():int
		{
			return mChannel;
		}
		
		public static function get which_game():int
		{
			return mProductID;
		}
		
		public static function get user_ip():String
		{
			return mUserIP;
		}
		
		public static function get tag():*
		{
			return mTag;
		}
		
		public static function get img_id():String
		{
			return mImgID;
		}
		
		public static function get verify_code():String
		{
			return mVerifyCode;
		}
	}
}
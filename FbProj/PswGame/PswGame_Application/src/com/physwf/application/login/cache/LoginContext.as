package com.physwf.application.login.cache
{
	import flash.utils.ByteArray;

	public class LoginContext
	{
		private static var mChannel:int;
		private static var mProductID:int;
		private static var mProductName:String;
		
		private static var mUserIP:int;
		private static var mTad:String;
		private static var mTadData:ByteArray;
		/**
		 *验证码图片id 
		 */		
		private static var mImgID:ByteArray;
		/**
		 *验证码 
		 */		
		private static var mVerifyCode:ByteArray;
		/**
		 *验证码图片数据 
		 */		
		private static var mImgData:ByteArray;
		
		public function LoginContext()
		{
		}
		
		public static function initialize():void
		{
			mChannel=65;
			mUserIP = 0;
			mTad = "";
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
		
		public static function get user_ip():int
		{
			return mUserIP;
		}
		
		public static function get tad():String
		{
			return mTad;
		}
		
		public static function get tadData():ByteArray
		{
			if(!mTadData)
			{
				mTadData = new ByteArray();
				mTadData.length = 128;
			}
			return mTadData;
		}
		
		public static function set img_id(v:ByteArray):void
		{
			mImgID = v;
		}
		
		public static function get img_id():ByteArray
		{
			if(!mImgID)
			{
				mImgID = new ByteArray();
				mImgID.length = 16;
			}
			return mImgID;
		}
		
		public static function set verify_code(v:ByteArray):void
		{
			mVerifyCode = v;
		}
		
		public static function get verify_code():ByteArray
		{
			if(!mVerifyCode)
			{
				mVerifyCode = new ByteArray();
				mVerifyCode.length = 6;
			}
			return mVerifyCode;
		}
		
		public static function set img_data(v:ByteArray):void
		{
			mImgData = v;
		}
		
		public static function get img_data():ByteArray
		{
			return mImgData;
		}
	}
}
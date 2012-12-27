package com.physwf.system.entity
{
	import com.physwf.system.vo.LoginInfo;
	import com.physwf.system.vo.PetInfo;
	import com.physwf.system.vo.UserInfo;

	public class MyInfo
	{
		/**
		 *登陆信息 
		 */		
		public static var loginInfo:LoginInfo;
		/**
		 * 角色信息 
		 */		
		public static var userInfo:UserInfo = new UserInfo();
		/**
		 * 宠物信息 
		 */		
		public static var petInfo:PetInfo;
		
		public function MyInfo()
		{
			
		}
	}
}
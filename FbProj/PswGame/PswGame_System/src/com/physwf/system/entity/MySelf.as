package com.physwf.system.entity
{
	import com.physwf.system.controllers.MySelfController;
	import com.physwf.system.services.MyService;
	import com.physwf.system.vo.LoginInfo;
	import com.physwf.system.vo.PetInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.EventDispatcher;

	public class MySelf extends EventDispatcher
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
		
		private static var controller:MySelfController;
		
		public static var service:MyService;
		
		public function MySelf()
		{
			
		}
		
		public static function initialize():void
		{
			service = new MyService();
		}
	}
}
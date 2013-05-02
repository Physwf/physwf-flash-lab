package com.physwf.system.entity
{
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.vo.LoginInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.EventDispatcher;

	public class MySelf extends EventDispatcher
	{
		/**
		 *登陆信息 
		 */		
		public static var loginInfo:LoginInfo = new LoginInfo();;
		/**
		 * 角色信息 
		 */		
		public static var userInfo:UserInfo = new UserInfo();
		
		public function MySelf()
		{
			
		}
		
		public function initialize():void
		{
			
		}
		/**
		 * 登陆 
		 * 
		 */		
		public function login():void
		{
		}
		/**
		 * 移动 old
		 * @param x
		 * @param y
		 * @param dir
		 * 
		 */		
		public function move(x:uint,y:uint,dir:uint):void
		{
		}
		/**
		 * 玩家移动
		 * @param timeStap
		 * @param path
		 * 
		 */		
		public function walkAlong(timeStap:uint,path:Vector.<uint>):void
		{
		}
		/**
		 * 进入地图 
		 * @param mapid
		 * @param x
		 * @param y
		 * 
		 */		
		public function enterMap(mapid:uint,x:uint,y:uint):void
		{
		}
		/**
		 *离开当前地图 
		 * 
		 */		
		public function leaveMap():void
		{
		}
		
		public function changeEquips():void
		{
		}
		
		public function syncPosition(x:uint,y:uint):void
		{
		}
		
		private function onMessage(e:MessageEvent):void
		{
		}
	}
}
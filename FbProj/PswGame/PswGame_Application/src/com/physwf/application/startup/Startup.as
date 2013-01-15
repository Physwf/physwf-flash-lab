package com.physwf.application.startup
{
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.shell.interfaces.IDestroyable;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.events.MyEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class Startup extends EventDispatcher implements IDestroyable
	{
		public function Startup()
		{
		}
		
		public function initialize(root:Sprite):void
		{
			System.initialize();
			var ip:Object = {host:MySelf.loginInfo.serverInfo.ip,port:MySelf.loginInfo.serverInfo.port};
			System.estabConnection(ip,onConect);
			ScreenManager.main = new ScreenManager(root);
		}
		
		private function onConect():void
		{
			System.myself.addEventListener(MyEvent.LOGIN_SUCCESS,onLoginSuccess);
			System.myself.login();
		}
		
		private function onLoginSuccess(e:MyEvent):void
		{
			System.myself.removeEventListener(MyEvent.LOGIN_SUCCESS,onLoginSuccess);
			dispatchEvent(new Event("finished"));
			return;
			System.myself.addEventListener(MyEvent.ENTER_MAP_SUCCESS,onEnterMapSuccess);
			System.myself.enterMap(
				MySelf.userInfo.map_id,
				MySelf.userInfo.map_x,
				MySelf.userInfo.map_y);
		}
		
		private function onEnterMapSuccess(e:MyEvent):void
		{
			dispatchEvent(new Event("finished"));
		}
		
		public function dispose():void
		{
			
		}
	}
}
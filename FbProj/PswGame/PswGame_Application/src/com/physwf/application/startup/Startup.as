package com.physwf.application.startup
{
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.shell.interfaces.IDestroyable;
	import com.physwf.system.System;
	import com.physwf.system.entity.BagSystem;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.events.BagEvent;
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
			System.bag.addEventListener(BagEvent.BAG_ITEM_LIST,onBagListSuccess);
			System.bag.getBagItems();
		}
		
		private function onBagListSuccess(e:BagEvent):void
		{
			System.bag.removeEventListener(BagEvent.BAG_ITEM_LIST,onBagListSuccess);
			
		}
		
		private function onEnterMapSuccess(e:MyEvent):void
		{
		}
		
		public function dispose():void
		{
			
		}
	}
}
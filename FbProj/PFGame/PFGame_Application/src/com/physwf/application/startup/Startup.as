package com.physwf.application.startup
{
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.components.ui.SpriteLoader;
	import com.physwf.shell.interfaces.IDestroyable;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.events.MyEvent;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;

	public class Startup extends EventDispatcher implements IDestroyable
	{
		public function Startup()
		{
		}
		
		public function initialize(root:Sprite):void
		{
			System.initialize();
//			var ip:Object = {host:MySelf.loginInfo.serverInfo.ip,port:MySelf.loginInfo.serverInfo.port};
//			System.estabConnection(ip,onConect);
			ScreenManager.main = new ScreenManager(root);
			onConect();
		}
		
		private function onConect():void
		{
			System.myself.addEventListener(MyEvent.LOGIN_SUCCESS,onLoginSuccess);
			var wid:uint = MySelf.loginInfo.serverInfo.id;
			System.myself.login(wid);
		}
		
		private function onLoginSuccess(e:MyEvent):void
		{
			System.myself.removeEventListener(MyEvent.LOGIN_SUCCESS,onLoginSuccess);
			//loadConfig();
			dispatchEvent(new Event("finished"));
		}
		
		private function loadConfig():void
		{
			var messenger:EventDispatcher = new EventDispatcher();
			messenger.addEventListener(Event.COMPLETE,onConfigComplete);
		}
		
		private function onConfigComplete(e:Event):void
		{
			e.target.removeEventListener(Event.COMPLETE,onConfigComplete);
			registerMouseCursor();
		}
		
		private function registerMouseCursor():void
		{
		}
		
		public function dispose():void
		{
			
		}
	}
}
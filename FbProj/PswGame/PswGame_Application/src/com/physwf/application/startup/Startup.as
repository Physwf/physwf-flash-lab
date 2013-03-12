package com.physwf.application.startup
{
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.components.ui.SpriteLoader;
	import com.physwf.engine.frame.config.FrameAssets;
	import com.physwf.shell.interfaces.IDestroyable;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.events.BagEvent;
	import com.physwf.system.events.MyEvent;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	
	import flashx.textLayout.elements.Configuration;

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
			loadConfig();
		}
		
		private function loadConfig():void
		{
			var messenger:EventDispatcher = new EventDispatcher();
			messenger.addEventListener(Event.COMPLETE,onConfigComplete);
			Config.initialize(messenger);
		}
		
		private function onConfigComplete(e:Event):void
		{
			e.target.removeEventListener(Event.COMPLETE,onConfigComplete);
			registerMouseCursor();
		}
		
		private function registerMouseCursor():void
		{
			var sLoader:SpriteLoader = SpriteLoader.getSameSpriteLoader(FrameAssets.DIR_ASSETS+"cursors.swf");
			function onComplete(e:Event):void
			{
				var assets:Vector.<BitmapData> = new Vector.<BitmapData>();
				for(var i:int=0;i<FrameAssets.CURSOR_AIM_ASSETS.length;++i)
				{
					var asset:BitmapData = sLoader.getAsset(FrameAssets.CURSOR_AIM_ASSETS[i]);
					assets.push(asset);
				}
				var aimCursor:MouseCursorData = new MouseCursorData();
				aimCursor.data = assets;
				aimCursor.hotSpot = new Point(16,16);
				aimCursor.frameRate = 1;
				Mouse.registerCursor(FrameAssets.CURSOR_AIM_NAME,aimCursor);
				dispatchEvent(new Event("finished"));
			};
			sLoader.addEventListener(Event.COMPLETE,onComplete);
			sLoader.load();
		}
		
		public function dispose():void
		{
			
		}
	}
}
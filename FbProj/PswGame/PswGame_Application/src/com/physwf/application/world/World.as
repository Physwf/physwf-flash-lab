package com.physwf.application.world
{
	import com.physwf.application.login.rpc.MessageEvent;
	import com.physwf.application.world.events.WorldEvent;
	import com.physwf.application.world.manager.Charactor;
	import com.physwf.application.world.manager.Map;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.MapView;
	import com.physwf.components.map.camera.Camera;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.events.MyEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	public class World
	{
		private const gameTimer:Timer = new Timer(33);
		
		private var map:Map;
		
		
		public function World()
		{
			super();
			map = new Map();
			map.attachLayer(ScreenManager.main.world);
			map.load();
		}
		

		public function initialize():void
		{
			System.myself.addEventListener(MyEvent.ENTER_MAP_SUCCESS,onEnterMapSuccess);
			System.myself.enterMap(MySelf.userInfo.map_id,MySelf.userInfo.map_x,MySelf.userInfo.map_y);
			
			ScreenManager.main.frameRate = 3;
			gameTimer.addEventListener(TimerEvent.TIMER,onTimer);
			gameTimer.start();
		}
		
		private function onEnterMapSuccess(e:MyEvent):void
		{
			
		}
		
		public function onTimer(e:TimerEvent):void
		{
			map.update();
			e.updateAfterEvent();
		}
	}
}
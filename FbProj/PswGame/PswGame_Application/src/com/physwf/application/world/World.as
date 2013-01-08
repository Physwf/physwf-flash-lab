package com.physwf.application.world
{
	import com.physwf.application.login.rpc.MessageEvent;
	import com.physwf.application.world.manager.Map;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.MapView;
	import com.physwf.components.map.camera.Camera;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.system.System;
	import com.physwf.system.events.MyEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	public class World
	{
		private const gameTimer:Timer = new Timer(33);
		
		private var mapManager:Map;
		
		
		public function World()
		{
			super();
			mapManager = new Map();
			mapManager.attachLayer(ScreenManager.main.world);
			mapManager.load();
		}
		
		public function initialize():void
		{
			ScreenManager.main.frameRate = 3;
			gameTimer.addEventListener(TimerEvent.TIMER,onTimer);
			gameTimer.start();
		}
		
		public function onTimer(e:TimerEvent):void
		{
			mapManager.update();
			e.updateAfterEvent();
		}
	}
}
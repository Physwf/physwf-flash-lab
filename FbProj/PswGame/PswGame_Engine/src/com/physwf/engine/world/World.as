package com.physwf.engine.world
{
	import com.physwf.components.map.wayfinding.astar.BiHeapAStar;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.engine.Engine;
	import com.physwf.engine.world.manager.Charactor;
	import com.physwf.engine.world.manager.Map;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.events.MyEvent;
	
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
			map.initialize();
			Charactor.astar = new BiHeapAStar();
			map.load();
			
			Engine.world = this;
		}
		

		public function initialize():void
		{
			System.myself.addEventListener(MyEvent.ENTER_MAP_SUCCESS,onEnterMapSuccess);
			System.myself.enterMap(MySelf.userInfo.map_id,MySelf.userInfo.map_x,MySelf.userInfo.map_y);
			
			ScreenManager.main.frameRate = 30;
		}
		
		private function onEnterMapSuccess(e:MyEvent):void
		{
			System.map.getMapUserList();
		}
		
		public function update():void
		{
			map.update();
		}
	}
}
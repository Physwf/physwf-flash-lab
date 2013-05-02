package com.physwf.engine.world
{
	import com.physwf.components.effects.Effect;
	import com.physwf.components.map.wayfinding.astar.BiHeapAStar;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.engine.Engine;
	import com.physwf.engine.world.events.WorldEvent;
	import com.physwf.engine.world.objects.Character;
	import com.physwf.engine.world.objects.Map;
	import com.physwf.engine.world.objects.Player;
	import com.physwf.engine.world.objects.Teleport;
	import com.physwf.shell.Application;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.events.MyEvent;
	
	import flash.events.Event;
	import flash.utils.Timer;
	
	public class World
	{
		private const gameTimer:Timer = new Timer(33);
		
		private var map:Map;
		
		
		public function World()
		{
			super();
			
			Effect.effects = new Vector.<Effect>();
//			EffectSystem.initialize();
			
			map = new Map();
			map.attachLayer(ScreenManager.main.world);
			map.initialize();
			Character.astar = new BiHeapAStar();
			
			Teleport.initialize();
			
			Engine.world = this;
		}

		public function initialize():void
		{
			System.myself.addEventListener(MyEvent.ENTER_MAP_SUCCESS,onFirstEnterMap);
			//初始化进入地图
			System.myself.enterMap(MySelf.userInfo.map_id,MySelf.userInfo.map_x,MySelf.userInfo.map_y);
			ScreenManager.main.frameRate = 30;
		}
		
		private function onFirstEnterMap(e:MyEvent):void
		{
			System.myself.removeEventListener(MyEvent.ENTER_MAP_SUCCESS,onFirstEnterMap);
			onEnterMapSuccess(e);
			// 目前 背包数据在进入地图后才能拉取
		}
		/**
		 * 切换地图 
		 * @param mapID
		 * @param mapX
		 * @param mapY
		 * 
		 */		
		public function switchMap(mapID:uint,mapX:uint,mapY:uint):void
		{
			if(mapID == MySelf.userInfo.map_id) return;
			
			System.map.onMapSwitchStart();
			
			Player.self.hide();
			map.sweep();
			
			System.myself.leaveMap();
			
			map.dispatchEvent(new WorldEvent(WorldEvent.WORLD_DESTROY));
			
			System.myself.addEventListener(MyEvent.ENTER_MAP_SUCCESS,onEnterMapSuccess);
			System.myself.enterMap(mapID,mapX,mapY);
			
			Application.application.sandBox.rebuildMapDomain();
		}
		
		private function onEnterMapSuccess(e:MyEvent):void
		{
			if(System.myself.hasEventListener(MyEvent.ENTER_MAP_SUCCESS))
				System.myself.removeEventListener(MyEvent.ENTER_MAP_SUCCESS,onEnterMapSuccess);
			
			System.map.onMapSwitchEnd();
			
			map.domain = Application.application.sandBox.curMapDomain;
			map.unload();
			map.unloadMapScript();
			//必须在这个事件之后才能请求地图上的玩家列表,否则玩家的寻路数据为空
			map.addEventListener(WorldEvent.MAP_READY,onWorldReady);
			map.load();
		}
		
		private function onWorldReady(e:Event):void
		{
			Player.self.show();
			map.removeEventListener(WorldEvent.MAP_READY,onWorldReady);
			map.addEventListener(WorldEvent.USERS_READY,onUsersReady);
			System.map.getMapUserList();
		}
		
		private function onUsersReady(e:WorldEvent):void
		{
			map.removeEventListener(WorldEvent.USERS_READY,onUsersReady);
		}
			
		private function onNpcReady(e:WorldEvent):void
		{
			map.removeEventListener(WorldEvent.NPCS_READY,onNpcReady);
			map.dispatchEvent(new WorldEvent(WorldEvent.WORLD_READY));
		}
		
		public function update():void
		{
			map.update();
		}
	}
}
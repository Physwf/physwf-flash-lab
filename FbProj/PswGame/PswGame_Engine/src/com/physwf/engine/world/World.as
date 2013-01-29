package com.physwf.engine.world
{
	import com.physwf.components.map.wayfinding.astar.BiHeapAStar;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.engine.Engine;
	import com.physwf.engine.world.events.WorldEvent;
	import com.physwf.engine.world.manager.Character;
	import com.physwf.engine.world.manager.Map;
	import com.physwf.shell.Application;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	import com.physwf.system.events.MyEvent;
	import com.physwf.system.events.NPCEvent;
	
	import flash.events.Event;
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
			Character.astar = new BiHeapAStar();
			
			Engine.world = this;
		}
		

		public function initialize():void
		{
			System.myself.addEventListener(MyEvent.ENTER_MAP_SUCCESS,onEnterMapSuccess);
			//初始化进入地图
			System.myself.enterMap(MySelf.userInfo.map_id,MySelf.userInfo.map_x,MySelf.userInfo.map_y);
			ScreenManager.main.frameRate = 30;
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
			System.myself.leaveMap();
			System.myself.enterMap(mapID,mapX,mapY);
			Application.application.sandBox.rebuildMapDomain();
		}
		
		private function onEnterMapSuccess(e:MyEvent):void
		{
			map.domain = Application.application.sandBox.curMapDomain;
			//必须在这个事件之后才能请求地图上的玩家列表,否则玩家的寻路数据为空
			map.addEventListener(WorldEvent.WORLD_READY,onWorldReady);
			map.load();
		}
		
		private function onWorldReady(e:Event):void
		{
			map.removeEventListener(WorldEvent.WORLD_READY,onWorldReady);
			map.addEventListener(WorldEvent.USERS_READY,onUsersReady);
			System.map.getMapUserList();
		}
		
		private function onUsersReady(e:WorldEvent):void
		{
			System.npc.addEventListener(NPCEvent.NPC_LIST,onMonstersReady);
			System.npc.getMonsterList();
		}
			
		private function onMonstersReady(e:NPCEvent):void
		{
			System.npc.removeEventListener(NPCEvent.NPC_LIST,onMonstersReady);
			System.bag.getBagItems();
		}
		
		public function update():void
		{
			map.update();
		}
	}
}
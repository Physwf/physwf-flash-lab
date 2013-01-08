package com.physwf.application.world.controllers
{
	import com.physwf.components.map.Map;
	import com.physwf.system.System;
	import com.physwf.system.entity.MapSystem;
	import com.physwf.system.entity.MySelf;
	
	import flash.events.SyncEvent;

	public class MapController
	{
		public static var instance:MapController = new MapController();
		
		private var mapModel:MapSystem;
		
		public function MapController()
		{
			mapModel = System.map;
		}
		
		public function getMapID():uint
		{
			return MySelf.userInfo.map_id;
		}
	}
}
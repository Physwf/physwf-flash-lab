package com.physwf.application.game.controllers
{
	import com.physwf.components.map.Map;
	import com.physwf.system.entity.MapSystem;

	public class MapController
	{
		public static var instance:MapController = new MapController();
		
		private var mapModel:MapSystem;
		
		public function MapController()
		{
		}
		
		public function getMapID():uint
		{
			return mapModel.mapInfo.id;
		}
	}
}
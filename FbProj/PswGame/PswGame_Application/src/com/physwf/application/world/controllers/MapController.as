package com.physwf.application.world.controllers
{
	import com.physwf.components.map.MapView;
	import com.physwf.system.System;
	import com.physwf.system.entity.MapSystem;
	import com.physwf.system.entity.MySelf;
	
	import flash.events.MouseEvent;
	import flash.events.SyncEvent;

	public class MapController
	{
		public static var instance:MapController = new MapController();
		
		private var mapModel:MapSystem;
		private var mapView:MapView;
		public var targetX:Number;
		public var targetY:Number;
		
		public function MapController()
		{
			mapModel = System.map;
		}
		
		public function initialize(view:MapView):void
		{
			mapView = view;
			mapView.addEventListener(MouseEvent.CLICK,onMapClick);
		}
		
		private function onMapClick(e:MouseEvent):void
		{
			System.myself.move(mapView.mouseX,mapView.mouseY,0);
			targetX = mapView.mouseX;
			targetY = mapView.mouseY;
		}
		
		public function getMapID():uint
		{
			return MySelf.userInfo.map_id;
		}
	}
}
package com.physwf.engine.world.controllers
{
	import com.physwf.components.map.MapView;
	import com.physwf.engine.Engine;
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
			mapView.bottom.addEventListener(MouseEvent.CLICK,onGroundClick);
		}
		
		private function onGroundClick(e:MouseEvent):void
		{
			targetX = mapView.mouseX;
			targetY = mapView.mouseY;
			System.myself.move(targetX,targetY,0);
//			System.myself.walkAlong(System.systemTime,Vector.<uint>([targetX,targetY]));
		}
		
		public function getMapID():uint
		{
			return MySelf.userInfo.map_id;
		}
	}
}
package com.physwf.system.entity 
{
	import com.physwf.system.controllers.MapController;
	import com.physwf.system.vo.MapInfo;
	
	import flash.events.EventDispatcher;

	public class MapSystem extends EventDispatcher
	{
		public var mapInfo:MapInfo;
		private var controller:MapController;
		
		public function MapSystem() 
		{
			
		}
		
		public function initialize():void
		{
		}

	} 
}
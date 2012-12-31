package com.physwf.system.controllers
{
	import com.physwf.system.entity.MapSystem;

	public class MapController
	{
		private var mapsystem:MapSystem;
		
		public function MapController()
		{
		}
		
		public function initialize(model:MapSystem):void
		{
			mapsystem = model;
		}
	}
}
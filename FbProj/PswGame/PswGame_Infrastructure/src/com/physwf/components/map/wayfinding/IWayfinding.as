package com.physwf.components.map.wayfinding {
	import com.physwf.components.map.data.IMapData;

	public interface IWayfinding {

		function makeMapData():void;
		function get mapData():IMapData;
		function set mapData(v:IMapData):void;

	} // end interface
} // end package
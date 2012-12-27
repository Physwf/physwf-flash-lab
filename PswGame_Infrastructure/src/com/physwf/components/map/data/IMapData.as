package com.physwf.components.map.data {
	import com.physwf.components.map.wayfinding.astar.Node;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	public interface IMapData {

		function initialize(landform:DisplayObject, rect:Rectangle, gridSize:uint, angle:int):void;
		function getNode(x:int,y:int):Node;
		function setStartNode(x:int,y:int):Node;
		function setEndNode(x:int,y:int):Node;
		function get startNode():Node;
		function get endNode():Node;
	} // end interface
} // end package
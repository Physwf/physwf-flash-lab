package com.physwf.components.map.camera {

	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.IMap;
	
	import flash.display.DisplayObject;

	public interface ICamera extends IUpdatable {

		function initialize(map:IMap):void;
		function set target(obj:DisplayObject):void;
		function get screen():IScreen;
		function moveTo(x:Number, y:Number, useTween:Boolean):void;
		function shake():void;

	} // end interface
} // end package
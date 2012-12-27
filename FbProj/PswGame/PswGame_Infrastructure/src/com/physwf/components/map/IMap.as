package com.physwf.components.map {

	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.map.camera.IScreen;
	import com.physwf.components.map.layer.depth.IDepthLayer;
	import com.physwf.components.map.layer.ground.IGroundLayer;
	import com.physwf.components.map.layer.landform.ILandformLayer;
	
	import flash.display.Sprite;

	public interface IMap extends IDisposible , IUpdatable 
	{
		function initialize():void;
		function set screen(v:IScreen):void;
		function get landfomLayer():ILandformLayer;
		function get depthLayer():IDepthLayer;
		function get groundLayer():IGroundLayer;
		function get display():Sprite;
	} // end interface
} // end package
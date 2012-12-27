package com.physwf.components.map.layer.tile
{
	import flash.geom.Rectangle;

	public interface ITileController
	{
		function set screenRect(v:Rectangle):void;
		function get screenRect():Rectangle;
		function render():void;
	}
}
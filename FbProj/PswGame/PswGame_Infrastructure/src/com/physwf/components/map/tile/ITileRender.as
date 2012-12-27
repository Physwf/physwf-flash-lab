package com.physwf.components.map.tile
{
	import flash.geom.Rectangle;

	public interface ITileRender
	{
		function set screenRect(v:Rectangle):void;
		function get screenRect():Rectangle;
		function render():void;
	}
}
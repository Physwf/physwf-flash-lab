package com.physwf.components.map.layer.tile
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IMeasurable;
	import com.physwf.components.interfaces.IView;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public interface ITile extends IDisposible,IMeasurable
	{
		function get view():IView;
		function setIndex(i:int,j:int):void;
		function install():void;
		function uninstall():void;
	}
}
package com.physwf.components.ui.layout
{
	import flash.display.DisplayObjectContainer;

	public interface IPopup
	{
		function toggle($parent:DisplayObjectContainer):void;
		function show($parent:DisplayObjectContainer):void;
		function hide():void;
	}
}
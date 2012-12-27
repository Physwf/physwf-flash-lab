package com.physwf.components.interfaces
{
	import flash.display.DisplayObject;

	public interface IView extends IDisposible
	{
		function get x():Number;
		function get y():Number;
		function set x(v:Number):void;
		function set y(v:Number):void;
		function set form(v:DisplayObject):void;
		function get form():DisplayObject;
		function render():void;
	}
}
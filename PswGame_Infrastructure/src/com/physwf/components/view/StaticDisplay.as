package com.physwf.components.view
{
	import com.physwf.components.interfaces.IView;
	
	import flash.display.DisplayObject;
	
	public class StaticDisplay implements IView
	{
		public function StaticDisplay(v:DisplayObject)
		{
		}
		
		public function get x():Number
		{
			return 0;
		}
		
		public function get y():Number
		{
			return 0;
		}
		
		public function set x(v:Number):void
		{
		}
		
		public function set y(v:Number):void
		{
		}
		
		public function set form(v:DisplayObject):void
		{
		}
		
		public function get form():DisplayObject
		{
			return null;
		}
		
		public function render():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function destroy():void
		{
		}
	}
}
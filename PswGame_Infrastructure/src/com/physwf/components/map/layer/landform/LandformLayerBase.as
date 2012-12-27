package com.physwf.components.map.layer.landform
{
	import com.physwf.components.map.camera.IScreen;
	import com.physwf.components.map.tile.ITileRender;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class LandformLayerBase implements ILandformLayer
	{
		private var _layerDisplay:Sprite;
		private var _screen:IScreen;
		
		public function LandformLayerBase(screen:IScreen)
		{
			_screen = screen;
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
		
		public function get tileController():ITileRender
		{
			return null;
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
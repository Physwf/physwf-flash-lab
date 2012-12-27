package com.physwf.components.map.layer.ground
{
	import com.physwf.components.map.camera.IScreen;
	import com.physwf.components.map.tile.BitmapTileRender;
	import com.physwf.components.map.tile.ITileRender;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class SpriteGroundLayer implements IGroundLayer
	{
		private var _layerDisplay:DisplayObject;
		private var _tileController:ITileRender;
		
		private var _x:Number;
		private var _y:Number;
		
		public function SpriteGroundLayer(screen:IScreen)
		{
			_layerDisplay = new Sprite();
			_tileController = new BitmapTileRender(_layerDisplay as Sprite);
			_tileController.screenRect = screen.rect;
		}
		
		public function get tileRender():ITileRender
		{
			return _tileController;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set x(v:Number):void
		{
			_x = v;
			_layerDisplay.x = v;
		}
		
		public function set y(v:Number):void
		{
			_y=v;
			_layerDisplay.y = v;
		}
		
		public function set form(v:DisplayObject):void
		{
			_layerDisplay = v;
		}
		
		public function get form():DisplayObject
		{
			return _layerDisplay;
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
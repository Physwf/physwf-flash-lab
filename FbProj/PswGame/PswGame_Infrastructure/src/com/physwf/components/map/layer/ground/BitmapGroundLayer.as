package com.physwf.components.map.layer.ground
{
	import com.physwf.components.map.camera.IScreen;
	import com.physwf.components.map.layer.tile.BitmapDataTileController;
	import com.physwf.components.map.layer.tile.ITileController;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class BitmapGroundLayer implements IGroundLayer
	{
		private var _layerDisplay:DisplayObject;
		private var _tileController:ITileController;
		private var _bitmapdata:BitmapData;
		
		private var _x:Number;
		private var _y:Number;
		
		public function BitmapGroundLayer(screen:IScreen)
		{
			_bitmapdata = new BitmapData(4095,4095,true,0)
			_tileController = new BitmapDataTileController(_bitmapdata);
			_tileController.screenRect = screen.rect;
			init();
		}
		
		private function init():void
		{
			_layerDisplay = new Bitmap(_bitmapdata);
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
			if(_x==v) return;
			_x=v;
			_layerDisplay.x = x;
			_tileController.render();
		}
		
		public function set y(v:Number):void
		{
			if(_y==v) return;
			_y=v;
			_layerDisplay.y = y;
			_tileController.render();
		}
		
		public function get tileController():ITileController
		{
			return _tileController;
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
package com.physwf.components.map.layer.ground
{
	import com.physwf.components.map.camera.IScreen;
	import com.physwf.components.map.tile.BitmapDataTileRender;
	import com.physwf.components.map.tile.ITileRender;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class GroundLayerRFC001 implements IGroundLayer
	{
		private var _layerDisplay:DisplayObject;
		private var _tileController:ITileRender;
		private var _bitmapdata:BitmapData;
		
		private var _x:Number;
		private var _y:Number;
		
		public function GroundLayerRFC001(screen:IScreen)
		{
			_bitmapdata = new BitmapData(4095,4095,true,0xFF0000FF);
			var seed:Number = Math.floor(Math.random() * 10);
			var channels:uint = BitmapDataChannel.RED | BitmapDataChannel.BLUE;
			_bitmapdata.perlinNoise(100, 80, 6, seed, false, true, channels, false, null);
			_tileController = new BitmapDataTileRender(_bitmapdata);
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
//			_tileController.render();
		}
		
		public function set y(v:Number):void
		{
			if(_y==v) return;
			_y=v;
			_layerDisplay.y = y;
//			_tileController.render();
		}
		
		public function get tileRender():ITileRender
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
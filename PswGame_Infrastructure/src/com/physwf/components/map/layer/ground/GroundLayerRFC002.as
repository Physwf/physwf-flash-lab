package com.physwf.components.map.layer.ground
{
	import com.physwf.components.map.camera.IScreen;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class GroundLayerRFC002 implements IGroundLayer
	{
		private var _screen:IScreen;
		private var _canvas:BitmapData;
		private var _layerDisplay:Bitmap;
		private var _source:BitmapData;
		
		public function GroundLayerRFC002(screen:IScreen)
		{
			_screen = screen;
			_canvas = new BitmapData(screen.rect.width,screen.rect.height,true,0);
			_layerDisplay = new Bitmap(_canvas);
			_source = new BitmapData(4095,4095,true,0xFF0000FF);
			var seed:Number = Math.floor(Math.random() * 10);
			var channels:uint = BitmapDataChannel.RED | BitmapDataChannel.BLUE;
			_source.perlinNoise(100, 80, 6, seed, false, true, channels, false, null);
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
			_layerDisplay = v as Bitmap;
		}
		
		public function get form():DisplayObject
		{
			return _layerDisplay;
		}
		
		public function render():void
		{
			var m:Matrix = new Matrix(1,0,0,1,-_screen.rect.topLeft.x,_screen.rect.topLeft.y);
//			_canvas.lock();
//			_canvas.draw(_source,m,null,null,null,false);
//			_canvas.unlock();
			_canvas.lock();
			_canvas.copyPixels(_source,_screen.rect,new Point());
			_canvas.unlock();
		}
		
		public function destroy():void
		{
		}
	}
}
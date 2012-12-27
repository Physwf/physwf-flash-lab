package com.physwf.components.map.tile
{
	import com.physwf.components.interfaces.IView;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class BitmapTile implements ITile
	{
		public static var size:Number=36.4;
		// w/2 = size * cos(53/2)
		// h/2 = size * sin(53/2)
		private var _rect:Rectangle;
		private var _canvas:Sprite;
		private var _viewData:Bitmap
		private var _view:IView;
		private var _i:int;
		private var _j:int;
		public function BitmapTile(canvas:Sprite)
		{
			_canvas = canvas;
		}
		
		public function get view():IView
		{
			return null;
		}
		
		public function setIndex(i:int, j:int):void
		{
			_i = i; _j = j;
			var w:Number = 2*size * Math.cos(26.5/180 * Math.PI);
			var h:Number = 2*size * Math.sin(26.5/180 * Math.PI);
			_rect = new Rectangle(_i*w,_j*h,w,h);
		}
		
		public function install():void
		{
			_viewData = new Bitmap(AssetsFactory.getBitmapData());
			_viewData.x = _rect.x;
			_viewData.y = _rect.y;
			_canvas.addChild(_viewData);
		}
		
		public function uninstall():void
		{
//			trace(_viewData);
//			if(_viewData) trace(_viewData.parent);
			_viewData && _viewData.parent && _viewData.parent.removeChild(_viewData);
			_viewData && _viewData.bitmapData.dispose();
			_viewData = null;
		}
		
		public function destroy():void
		{
		}
		
		public function get rect():Rectangle
		{
			return _rect;
		}
	}
}
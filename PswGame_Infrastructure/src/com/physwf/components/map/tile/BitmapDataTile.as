package com.physwf.components.map.tile
{
	import com.physwf.components.interfaces.IView;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class BitmapDataTile implements ITile
	{
		public static var size:Number=36.4;
		// w/2 = size * cos(53/2)
		// h/2 = size * sin(53/2)
		protected var _rect:Rectangle;
		protected var canvas:BitmapData;
		protected var _viewData:BitmapData
		private var _view:IView;
		protected var _i:int;
		protected var _j:int;
		
		protected var installed:Boolean = false;
		
		public function BitmapDataTile(bmd:BitmapData)
		{
			canvas = bmd;
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
			if(installed) return;
//			_viewData = new BitmapData(_rect.width,_rect.height,true,0xFFFFFFFF*Math.random());
			_viewData = AssetsFactory.getBitmapData();
			canvas.copyPixels(_viewData,_viewData.rect,rect.topLeft,null,null,true);
			installed = true;
		}
		
		public function uninstall():void
		{
			_viewData = new BitmapData(_rect.width,_rect.height,true,0xFFFFFFFF);
			canvas.copyPixels(_viewData,_viewData.rect,rect.topLeft,null,null,true);
			installed = false;
		}
		
		public function get rect():Rectangle
		{
			return _rect;
		}
		
		public function get view():IView
		{
			return _view;
		}
		
		public function destroy():void
		{
			_viewData && _viewData.dispose();
			_viewData = null;
		}
	}
}
package com.physwf.components.map.camera
{
	import flash.geom.Rectangle;

	public class ScreenBase implements IScreen
	{
		private var _rect:Rectangle;
		
		public function ScreenBase()
		{
			_rect = new Rectangle(0,0,960,560)
		}
		
		public function get rect():Rectangle
		{
			return _rect;
		}
		
		
	}
}
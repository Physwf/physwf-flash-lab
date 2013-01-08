package com.physwf.components.charactor
{
	import com.physwf.components.bitmap.display.BitmapPalyer;
	import com.physwf.components.interfaces.IUpdatable;
	
	import flash.display.Sprite;

	public class WearLayer extends Sprite implements IUpdatable
	{
		public var shoes:BitmapPalyer;
		public var pants:BitmapPalyer;
		public var upper:BitmapPalyer;
		public var hat:BitmapPalyer;
		public var weapon:BitmapPalyer;
		
		public function WearLayer()
		{
		}
		
		public function update():void
		{
			
		}
	}
}
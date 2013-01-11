package com.physwf.components.charactor
{
	import com.physwf.components.bitmap.display.BitmapPalyer;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.view.IAnimation;
	
	import flash.display.Sprite;

	public class WearLayer extends Sprite implements IAnimation,IUpdatable
	{
		public var shoes:BitmapPalyer;
		public var pants:BitmapPalyer;
		public var upper:BitmapPalyer;
		public var hat:BitmapPalyer;
		public var weapon:BitmapPalyer;
		
		private var mElements:Vector.<BitmapPalyer>;
		private const mNumElem:uint = 5;
		
		public function WearLayer()
		{
			mElements = new <BitmapPalyer>[shoes,pants,upper,hat,weapon];
		}
		
		public function set direction(v:uint):void
		{
			for(var i:uint=0;i<mNumElem;++i)
			{
				mElements[i].nextFrame();
			}
		}
		
		public function update():void
		{
			
		}
	}
}
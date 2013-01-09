package com.physwf.components.charactor
{
	import com.physwf.components.bitmap.display.BitmapPalyer;
	import com.physwf.components.interfaces.IUpdatable;
	
	import flash.display.Sprite;
	
	public class CharactorAnimation extends Sprite implements IUpdatable
	{
		private var mNude:BitmapPalyer;
		private var mWearLayer:WearLayer;
		private var mSpecialLayer:SpectialLayer;
		
		public function CharactorAnimation()
		{
			mNude = new BitmapPalyer();
			mWearLayer = new WearLayer();
			mSpecialLayer = new SpectialLayer();
			
			addChild(mNude);
			addChild(mWearLayer);
			addChild(mSpecialLayer);
			graphics.beginFill(0xFF0000,1);
			graphics.drawCircle(0,0,10);
			graphics.endFill();
		}
		
		public function update():void
		{
			mSpecialLayer.update();
			mWearLayer.update();
			mNude.nextFrame();
		}
		
		public function get specialLayer():Sprite
		{
			return mSpecialLayer;
		}

		public function get wearLayer():WearLayer
		{
			return mWearLayer;
		}

		public function get nude():BitmapPalyer
		{
			return mNude;
		}

	}
}
package com.physwf.components.charactor
{
	import com.physwf.components.bitmap.display.BitmapPalyer;
	
	import flash.display.Sprite;
	
	public class Charactor extends Sprite
	{
		private var mBone:BitmapPalyer;
		private var mWearLayer:WearLayer;
		private var mSpecialLayer:Sprite;
		
		public function Charactor()
		{
			mBone = new BitmapPalyer();
			mWearLayer = new WearLayer();
			mSpecialLayer = new Sprite();
			
			addChild(mBone);
			addChild(mWearLayer);
			addChild(mSpecialLayer);
		}

		public function get specialLayer():Sprite
		{
			return mSpecialLayer;
		}

		public function get wearLayer():WearLayer
		{
			return mWearLayer;
		}

		public function get bone():BitmapPalyer
		{
			return mBone;
		}

	}
}
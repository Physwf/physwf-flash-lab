package com.physwf.components.charactor
{
	import com.physwf.components.bitmap.display.BitmapFrame;
	import com.physwf.components.bitmap.display.BitmapPalyer;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.view.IAnimation;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class CharactorAnimation extends Sprite implements IAnimation,IUpdatable
	{
		private var mNude:BitmapPalyer;
		private var mWearLayer:WearLayer;
		private var mSpecialLayer:SpectialLayer;
		
		private var mNudeBmdt:Vector.<Vector.<BitmapFrame>>;
		
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
		/**
		 * 角色的朝向 
		 * @param v
		 * 
		 */		
		public function set direction(v:uint):void
		{
			mNude.bitmapFrames = mNudeBmdt[v];
			mWearLayer.direction = v;
		}
		
		public function update():void
		{
			mSpecialLayer.update();
			mWearLayer.update();
			mNude.nextFrame();
		}
		
		public function get specialLayer():SpectialLayer
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
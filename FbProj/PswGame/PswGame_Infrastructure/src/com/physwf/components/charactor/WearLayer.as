package com.physwf.components.charactor
{
	import com.physwf.components.bitmap.display.BitmapPalyer;
	import com.physwf.components.bitmap.net.SkeletonLoader;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.view.IAnimation;
	
	import flash.display.Sprite;

	public class WearLayer extends Sprite implements IAnimation
	{
		public var shoes:Wear;
		public var pants:Wear;
		public var upper:Wear;
		public var hat:Wear;
		public var weapon:Wear;
		
		private var mElements:Vector.<Wear>;
		public static const NUM_WEARS:uint = 5;
		
		public function WearLayer()
		{
			shoes = new Wear(this);
			pants = new Wear(this);
			upper = new Wear(this);
			hat = new Wear(this);
			weapon = new Wear(this);
			mElements = new <Wear>[shoes,pants,upper,hat,weapon];
		}
		
		public function set direction(v:uint):void
		{
			for(var i:uint=0;i<NUM_WEARS;++i)
			{
				mElements[i].direction = v;;
			}
		}
		
		public function set action(v:uint):void
		{
			for(var i:uint=0;i<NUM_WEARS;++i)
			{
				mElements[i].action = v;;
			}
		}
		
		public function set skeleton(v:SkeletonLoader):void
		{
		}
		
		public function set status(v:uint):void
		{
			for(var i:uint=0;i<NUM_WEARS;++i)
			{
				mElements[i].status = v;;
			}
		}
		
		public function update():void
		{
			for(var i:uint=0;i<NUM_WEARS;++i)
			{
				mElements[i].update();
			}
		}
	}
}
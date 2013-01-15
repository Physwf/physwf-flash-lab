package com.physwf.components.charactor
{
	import com.physwf.components.bitmap.display.BitmapFrame;
	import com.physwf.components.bitmap.display.BitmapPalyer;
	import com.physwf.components.bitmap.net.SkeletonLoader;
	import com.physwf.components.charactor.enum.CharacterAction;
	import com.physwf.components.charactor.enum.ISODirection;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.view.IAnimation;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class CharactorAnimation extends Sprite implements IAnimation
	{
		public static const NUM_ACTIONS:uint = 5;
		
		private var mNude:BitmapPalyer;
		private var mSkeleton:SkeletonLoader;
		
		private var mWearLayer:WearLayer;
		private var mSpecialLayer:SpectialLayer;
		/**
		 *					  direction|act|frames 
		 */		
		private var mNudeBmdt:Vector.<Vector.<Vector.<BitmapFrame>>>;
		
		private var mDirect:uint;
		private var mAction:uint;
		private var mStatus:uint;
		private var mDirty:Boolean;
		private var mActionDirty:Boolean;
		
		public function CharactorAnimation()
		{
			mNude = new BitmapPalyer();
			mWearLayer = new WearLayer();
			mSpecialLayer = new SpectialLayer();
			
			addChild(mNude);
			addChild(mWearLayer);
			addChild(mSpecialLayer);
			
			mNudeBmdt = new Vector.<Vector.<Vector.<BitmapFrame>>>(ISODirection.NUM_DIRECTIONS,true);
			
			for(var i:int=0;i<ISODirection.NUM_DIRECTIONS;++i)
			{
				mNudeBmdt[i] = new Vector.<Vector.<BitmapFrame>>(NUM_ACTIONS,true);
			}
			
			graphics.beginFill(0xFF0000,1);
			graphics.drawCircle(0,0,2);
			graphics.endFill();
		}
		
		public function initialize():void
		{
			
		}
		
		public function set skeleton(v:SkeletonLoader):void
		{
			mSkeleton = v;
			mSkeleton.load();
//			mSkeleton.addEventListener(Event.COMPLETE,function(e:Event):void { action = CharacterAction.ACTION_ATTACK});
		}
		
		/**
		 * 角色的朝向 
		 * @param v
		 * 
		 */		
		public function set direction(v:uint):void
		{
			if(v==3)
			{
				v = 1;
				scaleX = -1;
			}
			else if(v==4)
			{
				v = 0;
				scaleX = -1;
			}
			else if(v==5)
			{
				v = 7;
				scaleX = -1;
			}
			else
			{
				scaleX = 1;
			}
			mDirect = v;
			mWearLayer.direction = v;
			mDirty = true;
		}
		
		public function set action(v:uint):void
		{
			mAction = v;
			mActionDirty = true;
			mDirty = true;
		}
		
		public function set status(v:uint):void
		{
			mStatus = v;
			mDirty = true;
		}
		
		private function refresh():void
		{
			if(mActionDirty)
			{
				if(!mNudeBmdt[mDirect][mAction])
				{
					mNudeBmdt[mDirect][mAction] = mSkeleton.getCharacterAction(mDirect,mAction);
				}
				mNude.bitmapFrames = mNudeBmdt[mDirect][mAction];
				mActionDirty = false;
			}
			else
			{
				if(!mNudeBmdt[mDirect][mStatus])
				{
					mNudeBmdt[mDirect][mStatus] = mSkeleton.getCharacterAction(mDirect,mStatus);
				}
				mNude.bitmapFrames = mNudeBmdt[mDirect][mStatus];
			}
		}
		
		public function update():void
		{
			if(mDirty)
			{
				refresh();
				mDirty = false;
			}
			mSpecialLayer.update();
//			mWearLayer.update();
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
package com.physwf.components.charactor
{
	import com.physwf.components.bitmap.display.BitmapFrame;
	import com.physwf.components.bitmap.display.BitmapPlayer;
	import com.physwf.components.bitmap.events.PackageEvent;
	import com.physwf.components.bitmap.net.SkeletonLoader;
	import com.physwf.components.charactor.enum.AnimationSystem;
	import com.physwf.components.charactor.enum.CharacterAction;
	import com.physwf.components.charactor.enum.ISODirection;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.view.ISkeleton;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class CharacterAnimation extends Sprite implements ISkeleton
	{
		public static const NUM_ACTIONS:uint = 5;
		/**
		 *动画资源的系统，其值为AnimationSystem枚举值之一,默认为0，即AOTM系统
		 */		
		private var mSystem:uint;
		
		private var mNude:BitmapPlayer;
		private var mSkeleton:SkeletonLoader;
		
		private var mWearLayer:WearLayer;
		private var mSpecialLayer:SpectialLayer;
		/**
		 *					  direction|act|frames 
		 */		
		private var mNudeBmdt:Vector.<Vector.<Vector.<BitmapFrame>>>;
		/*骨架是否加载*/
		private var isSkeletonReady:Boolean = false;
		private var mDirect:uint;
		private var mAction:uint;
		private var mStatus:uint;
		private var mDirty:Boolean;
		private var mActionDirty:Boolean;
		
		public function CharacterAnimation(system:uint = 0)
		{
			mSystem = system;
			mNude = new BitmapPlayer();
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
			
			mSkeleton.addEventListener(PackageEvent.PACKAGE_ALL_INITED,
				function(e:Event):void 
				{ 
					isSkeletonReady = (mSkeleton.loadFlag == SkeletonLoader.LOAD_FLAG_YES);
					status = CharacterAction.ACTION_STAND;
					direction = ISODirection.LEFT;
				});
			
			mSkeleton.loadNude();//一定要在侦听之后加载，否则侦听不到
		}
		
		/**
		 * 角色的朝向 
		 * @param v
		 * 
		 */		
		public function set direction(v:uint):void
		{
			if(mSystem == AnimationSystem.AOTM)
			{
				if(v == ISODirection.LEFT_DOWN)
				{
					v = ISODirection.RIGHT_DOWN;
					scaleX = -1;
				}
				else if(v == ISODirection.LEFT)
				{
					v = ISODirection.RIGHT;
					scaleX = -1;
				}
				else if(v == ISODirection.LEFT_UP)
				{
					v = ISODirection.RIGHT_UP;
					scaleX = -1;
				}
				else
				{
					scaleX = 1;
				}
			}
			else if(mSystem == AnimationSystem.MOLE)
			{
				if(v == ISODirection.RIGHT_DOWN)
				{
					v = ISODirection.LEFT_DOWN;
					scaleX = -1;
				}
				else if(v == ISODirection.RIGHT)
				{
					v = ISODirection.LEFT;
					scaleX = -1;
				}
				else if(v == ISODirection.RIGHT_UP)
				{
					v = ISODirection.LEFT_UP;
					scaleX = -1;
				}
				else
				{
					scaleX = 1;
				}
			}

			if(mDirect == v) return;
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
				mNude.currentFrame = 0;
				mNude.bitmapFrames = mNudeBmdt[mDirect][mAction];
				mNude.addEventListener(Event.COMPLETE,onActioinComplete);
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
		
		private function onActioinComplete(e:Event):void
		{
			mNude.removeEventListener(Event.COMPLETE,onActioinComplete);
		}
			
		public function update():void
		{
			if(isSkeletonReady) 
			{
				if(mDirty)
				{
					refresh();
					mDirty = false;
				}
				mSpecialLayer.update();
				//mWearLayer.update();
				mNude.nextFrame();
			}
		}
		
		public function get specialLayer():SpectialLayer
		{
			return mSpecialLayer;
		}

		public function get wearLayer():WearLayer
		{
			return mWearLayer;
		}

		public function get nude():BitmapPlayer
		{
			return mNude;
		}

	}
}
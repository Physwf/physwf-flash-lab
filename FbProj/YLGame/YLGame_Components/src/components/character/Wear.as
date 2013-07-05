package components.character
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import components.bitmap.display.BitmapFrame;
	import components.bitmap.display.BitmapPlayer;
	import components.bitmap.net.SkeletonLoader;
	import components.character.enums.CharacterAction;
	import components.character.enums.ISODirection;
	import components.interfaces.IAnimation;
	import components.view.ISkeleton;
	
	public class Wear implements ISkeleton,IAnimation
	{
		public var display:BitmapPlayer;
		private var mWearBmdt:Vector.<Vector.<Vector.<BitmapFrame>>>;
		private var mSkeleton:SkeletonLoader;
		
		private var mLayer:Sprite;
		
		private var mDirect:uint;
		private var mAction:uint;
		private var mStatus:uint;
		private var mDirty:Boolean;
		private var mActionDirty:Boolean;
		private var isSkeletonReady:Boolean;
		
		public function Wear(layer:Sprite,depth:uint)
		{
			mLayer = layer;
			display = new BitmapPlayer();
			mWearBmdt = new Vector.<Vector.<Vector.<BitmapFrame>>>(8,true);
			for(var i:int=0;i<ISODirection.NUM_DIRECTIONS;++i)
			{
				mWearBmdt[i] = new Vector.<Vector.<BitmapFrame>>(ISODirection.NUM_DIRECTIONS,true);
			}
			layer.addChildAt(display,depth);
		}
		
		public function setDepth(index:uint):void
		{
			mLayer.setChildIndex(display,index);
		}
		
		public function set action(v:uint):void
		{
			mAction = v;
			mActionDirty = true;
			mDirty = true;
		}
		
		public function set direction(v:uint):void
		{
			mDirect = v;
			mDirty = true;
		}
		
		public function set skeleton(v:SkeletonLoader):void
		{
			mSkeleton = v;
			mSkeleton.addEventListener(Event.COMPLETE,
				function(e:Event):void 
				{ 
					isSkeletonReady = true;
				});
			mSkeleton.load();
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
				if(!mWearBmdt[mDirect][mAction])
				{
					mWearBmdt[mDirect][mAction] = mSkeleton.getAction(mDirect,CharacterAction.idToName(mAction));
				}
				display.bitmapFrames = mWearBmdt[mDirect][mAction];
				mActionDirty = false;
			}
			else
			{
				if(!mWearBmdt[mDirect][mStatus])
				{
					mWearBmdt[mDirect][mStatus] = mSkeleton.getAction(mDirect,CharacterAction.idToName(mStatus));
				}
				display.bitmapFrames = mWearBmdt[mDirect][mStatus];
			}
		}
		
		public function step(step:uint):void
		{
			if(isSkeletonReady)
			{
				if(mDirty)
				{
					refresh();
					mDirty = false;
				}
				display.step(step);
			}
		}
	}
}
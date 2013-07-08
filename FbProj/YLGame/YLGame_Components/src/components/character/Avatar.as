package components.character
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import components.bitmap.net.SkeletonLoader;
	import components.interfaces.IAnimation;
	import components.view.ISkeleton;
	
	public class Avatar implements ISkeleton, IAnimation
	{
		private var mLayer:Sprite;
		private var mStartDepth:uint;
		private var mNumElements:uint;
		private var mElements:Vector.<Wear>;
		private var mName:String;
		
		public function Avatar(layer:Sprite,depth:uint,numElements:uint,name:String=null)
		{
			mLayer =layer;
			mStartDepth = depth;
			mNumElements = numElements;
			mElements = new Vector.<Wear>(numElements,true);
			for(var i:uint=0;i<numElements;++i)
			{
				mElements[i] = new Wear(layer,mStartDepth+i);
			}
			mName = name;
		}
		
		public function changeWear(id:uint,skeleton:SkeletonLoader):void
		{
			mElements[id].skeleton = skeleton;
			skeleton.addEventListener(Event.COMPLETE,
				function(e:Event):void 
				{ 
					mElements[id].display.currentFrame = mElements[0].display.currentFrame;
				});
			skeleton.load();
		}
		
		public function setDepths(depths:Vector.<uint>):void
		{
			for(var i:uint=0;i<mNumElements;++i)
			{
				mElements[i].setDepth(mStartDepth+depths[i]);
			}
		}
		
		public function set skeleton(v:SkeletonLoader):void
		{
			trace("无效的方法");
		}
		
		public function set direction(v:uint):void
		{
			for(var i:uint=0;i<mNumElements;++i)
			{
				mElements[i].direction = v;;
			}
		}
		
		public function set action(v:uint):void
		{
			for(var i:uint=0;i<mNumElements;++i)
			{
				mElements[i].action = v;;
			}
		}
		
		public function set status(v:uint):void
		{
			for(var i:uint=0;i<mNumElements;++i)
			{
				mElements[i].status = v;;
			}
		}
		
		public function set cull(v:Boolean):void
		{
			for(var i:uint=0;i<mNumElements;++i)
			{
				mElements[i].cull = v;;
			}
		}
		
		public function step(step:uint):void
		{
			for(var i:uint=0;i<mNumElements;++i)
			{
				mElements[i].step(step);
			}
		}
	}
}
package com.physwf.components.resource
{
	import com.physwf.components.interfaces.IUpdatable;
	
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	public class ResourceManager implements IUpdatable
	{
		private var mWaitList:Dictionary;
		private var mDestroyList:Vector.<ResourceCache>;
		
		private var mLastTime:uint;
		
		public function ResourceManager()
		{
			mWaitList = new Dictionary(true);
			mDestroyList = new Vector.<ResourceCache>();
			mLastTime = getTimer();
		}
		
		public function addToWaitList(res:ResourceCache):void
		{
			mWaitList[res] = 0;
		}
		
		public function removeFromWaitList(res:ResourceCache):void
		{
			delete mWaitList[res];
		}
		
		public function update():void
		{
			//处理等待队列
			var now:uint = getTimer();
			if(now - mLastTime > 1000)
			{
				mLastTime = now;
				for each(var cache:ResourceCache in mWaitList)
				{
					if(mWaitList[cache]>5)
					{
						mDestroyList.push(cache);
						delete mWaitList[cache];
					}
					else
					{
						mWaitList[cache]++;
					}
				}
			}
			//处理销毁队列
			while(mDestroyList.length)
			{
				if(getTimer() - now > 10) break;
				cache = mDestroyList.shift();
				cache.destroy();
			}
		}
	}
}
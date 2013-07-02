package components.resource
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import components.interfaces.IUpdatable;
	
	public class ResourceManager implements IUpdatable
	{
		private var mDestroyList:Vector.<*> = new Vector.<ResourceCache>();
		private var mWaitList:Dictionary;
		private var mLastTime:uint;
		
		public function ResourceManager()
		{
			mWaitList = new Dictionary(true);
			mLastTime = getTimer();
		}
		
		public function addToWaitList(res:ResourceCache):void
		{
			mWaitList[res] = 0;//等待列表以资源缓存为键，以等待时间（秒为单位）为值
		}
		
		public function removeFromWaitList(res:ResourceCache):void
		{
			delete mWaitList[res];
		}
		
		public function update(delta:uint = 0):void
		{
			//处理等待队列
			var now:uint = getTimer();
			if(now - mLastTime > 1000)//每一秒检查一次
			{
				mLastTime = now;
				for each(var cache:ResourceCache in mWaitList)
				{
					if(mWaitList[cache]>5)//大于5秒的移入销毁列表
					{
						mDestroyList.push(cache);
						delete mWaitList[cache];
					}
					else
					{
						mWaitList[cache]++;//累加计时
					}
				}
			}
			//处理销毁队列
			while(mDestroyList.length)
			{
				if(getTimer() - now > 3) break;//销毁时间大于3毫秒就退出
				//先从列表中取出，然后执行销毁，
				//由于缓存资源本身也会控制时间，所以他们并不一定一次就能完全销毁
				//通过检查cache.isDestroied属性，可以知道cache是否完全销毁
				//如果没有完全销毁，应放回销毁列表等待下一次空闲周期
				cache = mDestroyList.shift();
				cache.destroy();
				if(!cache.isDestroied)
				{
					mDestroyList.unshift(cache);
				}
			}
		}
	}
}
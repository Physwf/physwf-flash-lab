package com.physwf.components.resource
{
	import com.physwf.components.interfaces.IDisposible;
	
	import flash.events.EventDispatcher;

	/**
	 * 资源，可以实现为单独的资源数据对象，也可以实现为多个资源组成的资源包对象，如SkeletonLoader,SpriteLoader等等。 
	 * @author Physwf
	 * 
	 */	
	public class ResourceCache extends EventDispatcher implements IDisposible
	{
		protected static var mResMgr:ResourceManager = new ResourceManager();
		protected var mRefCount:uint;//引用次数
		
		public function ResourceCache()
		{
		}
		
		protected function incRefCount():void
		{
			mRefCount++;
		}
		
		protected function decRefCount():void
		{
			if(mRefCount == 0) throw "组件错误，该错误说明累加和递减不平衡，请检查逻辑设计！";
			mRefCount--;
		}
		
		public function release():void
		{
			if(mRefCount > 0)
			{
				mRefCount--;
			}
			if(mRefCount == 0)
			{
				mResMgr.addToWaitList(this);
			}
		}
		
		public function destroy():void
		{
			
		}
	}
}
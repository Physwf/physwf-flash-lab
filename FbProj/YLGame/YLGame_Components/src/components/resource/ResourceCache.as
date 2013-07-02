package components.resource
{
	import flash.events.EventDispatcher;
	
	import components.interfaces.IDisposible;
	
	/**
	 * 资源，可以实现为单独的资源数据对象，也可以实现为多个资源组成的资源包对象，如SkeletonLoader,SpriteLoader等等。 
	 * @author Physwf
	 * 
	 */	
	public class ResourceCache extends EventDispatcher implements IDisposible
	{
		public static const RM:ResourceManager = new ResourceManager();
		protected var mRefCount:uint;//引用次数
		/*资源是否完全销毁，某些大对象的销毁可能很耗时，因此可以分在多个帧周期中进行销毁，从而需要这样一个字段来标识是否完全销毁*/		
		public function get isDestroied():Boolean { return false; }
		
		public function ResourceCache()
		{
		}
		
		protected function incRefCount():void
		{
			if(mRefCount == 0)
			{
				RM.removeFromWaitList(this);
			}
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
				RM.addToWaitList(this);
			}
		}
		
		public function destroy():void
		{
			
		}
	}
}
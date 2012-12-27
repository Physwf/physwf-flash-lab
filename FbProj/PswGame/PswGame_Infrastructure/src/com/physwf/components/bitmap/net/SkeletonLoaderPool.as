package com.physwf.components.bitmap.net
{
	import com.physwf.components.interfaces.IDisposible;
	
	import flash.utils.Dictionary;
	
	public class SkeletonLoaderPool implements IDisposible
	{
		private static var _skeletonLoaderLib:Dictionary = new Dictionary();
		
		public static function getLoader(tag:String):SkeletonLoader
		{
			var sLoader:SkeletonLoader = _skeletonLoaderLib[tag];
			return sLoader;
		}
		public static function addLoader(tag:String,sLoader:SkeletonLoader):void
		{
			if(_skeletonLoaderLib[tag])
			{
				throw "操作错误，该骨架加载器已经存在！";
			}
			_skeletonLoaderLib[tag] = sLoader;
		}
		
		public static function deleteLoader(tag:String):SkeletonLoader
		{
			var sLoader:SkeletonLoader = _skeletonLoaderLib[tag];
			if(!sLoader)
			{
				throw "操作错误，该骨架加载器不存在！";
			}
			delete _skeletonLoaderLib[tag];
			return sLoader;
		}
		
		public function destroy():void
		{
			
		}
	}
}
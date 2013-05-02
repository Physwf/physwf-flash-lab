package com.physwf.components.charactor.factory
{
	import com.physwf.components.bitmap.net.SkeletonLoader;
	
	public class BoyFactory implements ICharacterFactory
	{
		public static const URL_NUDE_RES:String = "resource/wear/nude/1";
		public static const URL_WEAR_RES:String = "resource/wear/";
		
		public function BoyFactory()
		{
		}
		
		public function getNude():SkeletonLoader
		{
			return SkeletonLoader.getSameSkeletonLoader(URL_NUDE_RES);
		}
		
		public function getWear(id:uint):SkeletonLoader
		{
			return SkeletonLoader.getSameSkeletonLoader(URL_WEAR_RES+id);
		}
	}
}
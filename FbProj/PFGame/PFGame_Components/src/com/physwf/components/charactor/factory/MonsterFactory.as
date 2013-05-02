package com.physwf.components.charactor.factory
{
	import com.physwf.components.bitmap.net.SkeletonLoader;
	/**
	 * 怪物工厂。怪物一般不具有avatar系统，nude和wear没有分离，所以为了方便直接通过getWear()接口来获取资源 
	 * @author joe
	 * 
	 */	
	public class MonsterFactory implements ICharacterFactory
	{
		public static const URL_NUDE_RES:String = "resource/wear/nude/1";
		public static const URL_MON_RES:String = "resource/monster/";
		
		public function MonsterFactory()
		{
		}
		
		public function getNude():SkeletonLoader
		{
			throw "请通过getWear接口来获取怪物资源！";
			return null;
		}
		
		public function getWear(id:uint):SkeletonLoader
		{
			return SkeletonLoader.getSameSkeletonLoader(URL_MON_RES+id);
		}
	}
}
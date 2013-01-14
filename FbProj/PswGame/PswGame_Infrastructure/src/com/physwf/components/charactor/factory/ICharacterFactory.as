package com.physwf.components.charactor.factory
{
	import com.physwf.components.bitmap.net.SkeletonLoader;

	public interface ICharacterFactory
	{
		function getNude():SkeletonLoader;
		function getWear(id:uint):SkeletonLoader;
	}
}
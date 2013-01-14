package com.physwf.components.view
{
	import com.physwf.components.bitmap.net.SkeletonLoader;
	import com.physwf.components.interfaces.IUpdatable;

	public interface IAnimation extends IUpdatable
	{
		function set skeleton(v:SkeletonLoader):void;
		function set direction(v:uint):void;
		function set action(v:uint):void;
		function set status(v:uint):void;
	}
}
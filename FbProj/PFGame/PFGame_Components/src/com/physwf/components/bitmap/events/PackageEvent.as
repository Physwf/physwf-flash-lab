package com.physwf.components.bitmap.events
{
	import flash.events.Event;
	
	public class PackageEvent extends Event
	{
		public static const PACKAGE_INITED:String = "p_i";// 位图数据包初始化完毕
		public static const PACKAGE_ALL_INITED:String = "p_a_i";// （一个skeletonLoader的）所有位图数据包都初始化完毕
		
		public function PackageEvent(type:String)
		{
			super(type);
		}
	}
}
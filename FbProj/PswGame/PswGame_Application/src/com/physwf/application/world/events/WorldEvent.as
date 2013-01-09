package com.physwf.application.world.events
{
	import flash.events.Event;
	
	public class WorldEvent extends Event
	{
		public static const WORLD_READY:String = "w_r";//世界的地形数据已经加载完毕
		
		public function WorldEvent(type:String)
		{
			super(type, false, false);
		}
	}
}
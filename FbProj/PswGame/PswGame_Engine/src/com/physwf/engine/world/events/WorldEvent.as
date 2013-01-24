package com.physwf.engine.world.events
{
	import flash.events.Event;
	
	public class WorldEvent extends Event
	{
		public static const WORLD_READY:String = "w_r";//世界的地形数据已经加载完毕
		public static const USERS_READY:String = "u_r";//地图上玩家的显示完毕
		public static const MONS_READY:String = "m_r";//
		
		public function WorldEvent(type:String)
		{
			super(type, false, false);
		}
	}
}
package com.physwf.engine.world.events
{
	import flash.events.Event;
	
	public class WorldEvent extends Event
	{
		public static const MAP_READY:String = "m_r";//世界的地形数据已经加载完毕
		public static const USERS_READY:String = "u_r";//地图上玩家的显示完毕
		public static const MONS_READY:String = "m_re";//
		public static const NPCS_READY:String = "n_r";//npc
		//世界切换（包括，地图跳转，玩家列表，怪物列表三个过程）
		public static const WORLD_DESTROY:String = "w_d";
		public static const WORLD_READY:String = "w_r";
		
		public function WorldEvent(type:String)
		{
			super(type, false, false);
		}
	}
}
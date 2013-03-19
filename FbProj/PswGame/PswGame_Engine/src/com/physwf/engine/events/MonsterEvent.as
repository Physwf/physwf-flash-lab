package com.physwf.engine.events
{
	import com.physwf.system.vo.MonsterInfo;
	
	import flash.events.Event;
	
	public class MonsterEvent extends Event
	{
		public static const MONSTER_SELECTED:String = "m_s";
		public static const MONSTER_DIE:String = "m_d";
		
		private var mInfo:MonsterInfo;
		
		public function MonsterEvent(type:String, info:MonsterInfo = null)
		{
			mInfo = info;
			super(type, false, false);
		}
		
		public function get info():MonsterInfo
		{
			return mInfo;
		}
	}
}
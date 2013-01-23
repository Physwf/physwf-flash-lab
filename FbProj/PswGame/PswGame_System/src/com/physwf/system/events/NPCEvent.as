package com.physwf.system.events
{
	import com.physwf.system.vo.MonsterInfo;
	import com.physwf.system.vo.NPCInfo;
	
	import flash.events.Event;
	
	public class NPCEvent extends Event
	{
		public static const NPC_LIST:String = "n_l";
		
		private var mInfo:MonsterInfo;
		
		public function NPCEvent(type:String,info:MonsterInfo)
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
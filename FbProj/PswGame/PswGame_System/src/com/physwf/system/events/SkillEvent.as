package com.physwf.system.events
{
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.Event;
	
	public class SkillEvent extends Event
	{
		public static const SKILL_LEARNED:String = "s_l";
		public static const SKILL_UPGRADE:String = "s_u";
		
		private var mInfo:SkillInfo;
		
		public function SkillEvent(type:String, info:SkillInfo)
		{
			mInfo = info;
			super(type, false, false);
		}
		
		public function get info():SkillInfo
		{
			return info;
		}
	}
}
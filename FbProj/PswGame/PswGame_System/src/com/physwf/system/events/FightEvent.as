package com.physwf.system.events
{
	import com.physwf.system.vo.FightInfo;
	
	import flash.events.Event;
	
	public class FightEvent extends Event
	{
		public static const FIGHT_RESULT:String = "f_r";
		public static const FIGHT_DEATH:String = "f_d";
		
		private var mInfo:FightInfo;
		
		public function FightEvent(type:String,info:FightInfo)
		{
			super(type, false, false);
			mInfo = info;
		}
		
		public function get info():FightInfo
		{
			return mInfo;
		}
	}
}
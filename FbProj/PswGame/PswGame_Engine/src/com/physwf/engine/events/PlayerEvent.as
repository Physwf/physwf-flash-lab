package com.physwf.engine.events
{
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.Event;
	
	public class PlayerEvent extends Event
	{
		public static const PLAYER_SELECTED:String = "c_s";
		public static const PLAYER_DIE:String = "c_d";
		
		private var mInfo:UserInfo;
		
		public function PlayerEvent(type:String, info:UserInfo=null)
		{
			mInfo = info;
			super(type, false, false);
		}
		
		public function get info():UserInfo
		{
			return mInfo;
		}
	}
}
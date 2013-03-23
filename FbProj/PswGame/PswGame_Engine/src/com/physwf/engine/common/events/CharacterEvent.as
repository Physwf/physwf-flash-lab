package com.physwf.engine.common.events
{
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.Event;
	
	public class CharacterEvent extends Event
	{
		
		private var mInfo:UserInfo;
		
		public function CharacterEvent(type:String,info:UserInfo=null)
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
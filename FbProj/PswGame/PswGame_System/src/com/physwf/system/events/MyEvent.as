package com.physwf.system.events
{
	import flash.events.Event;
	
	public class MyEvent extends Event
	{
		public static const LOGIN_SUCCESS:String = "login_success";
		public static const KICKED_OFF:String = "kicked_off";
		public static const ENTER_MAP_SUCCESS:String = "enter_map_success";
		
		public function MyEvent(type:String)
		{
			super(type, false, false);
		}
	}
}
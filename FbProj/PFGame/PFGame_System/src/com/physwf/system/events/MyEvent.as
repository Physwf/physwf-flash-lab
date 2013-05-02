package com.physwf.system.events
{
	import flash.events.Event;
	
	public class MyEvent extends Event
	{
		public static const LOGIN_SUCCESS:String = "l_s";
		public static const KICKED_OFF:String = "k_o";
		public static const ENTER_MAP_SUCCESS:String = "e_m_s";
		public static const LEAVE_MAP_SUCCESS:String = "l_m_s";
		public static const SELF_MOVE_ALLOWED:String = "s_m_a";
		public static const CHANGE_EQUIPS:String = "c_e";
		public static const EXP_MONEY_CHANGE:String = "e_m_c";
		
		public function MyEvent(type:String)
		{
			super(type, false, false);
		}
	}
}
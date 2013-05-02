package com.physwf.system.events
{
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.Event;
	
	public class MapEvent extends Event
	{
		public static const MAP_USER_LIST_SUCCESS:String = "m_u_l_s";
		public static const MAP_USER_LIST_DETAIL_SUCCESS:String = "m_u_l_d_s";
		public static const MAP_USER_ENTER_MAP:String = "m_u_e_m";
		public static const MAP_USER_LEAVE_MAP:String = "m_u_l_m";
		public static const MAP_USER_MOVE:String = "m_u_mv";
		public static const MAP_USER_LEVEL_UP:String = "m_u_l_u";
		public static const MAP_USER_ATTRI_CHANGE:String = "m_u_a_c";
		
		private var _userInfo:UserInfo;
		
		public function MapEvent(type:String,userInfo:UserInfo=null)
		{
			super(type, false, false);
			_userInfo = userInfo;
		}
		
		public function get userInfo():UserInfo
		{
			return _userInfo;
		}
	}
}
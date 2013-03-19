package com.physwf.system.events
{
	import com.physwf.system.vo.DropInfo;
	
	import flash.events.Event;
	
	public class DropEvent extends Event
	{
		public static const DROP_NOTI_NEW:String = "d_n_n";
		public static const DROP_PICKED_UP:String = "d_p_u";
		
		private var mInfo:DropInfo;
		
		public function DropEvent(type:String, info:DropInfo)
		{
			mInfo = info;
			super(type, false, false);
		}
		
		public function get info():DropInfo
		{
			return mInfo;
		}
	}
}
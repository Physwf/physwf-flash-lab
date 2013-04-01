package com.physwf.system.events
{
	import com.physwf.system.vo.LootInfo;
	
	import flash.events.Event;
	
	public class LootEvent extends Event
	{
		public static const DROP_NOTI_NEW:String = "d_n_n";
		public static const DROP_PICKED_UP:String = "d_p_u";
		
		private var mInfo:LootInfo;
		
		public function LootEvent(type:String, info:LootInfo)
		{
			mInfo = info;
			super(type, false, false);
		}
		
		public function get info():LootInfo
		{
			return mInfo;
		}
	}
}
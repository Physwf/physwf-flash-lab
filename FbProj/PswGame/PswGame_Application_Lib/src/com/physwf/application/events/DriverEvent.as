package com.physwf.application.events
{
	import flash.events.Event;
	
	public class DriverEvent extends Event
	{
		public static const DRIVER_AVALIABLE:String = "driver_avaliable";
		public static const DRIVER_PROGRESS:String = "driver_progress";
		
		private var mData:*;
		
//		public static const DR
		public function DriverEvent(type:String, data:*)
		{
			super(type, false, false);
			mData = data;
		}
		
		public function get data():*
		{
			return mData;
		}
	}
}
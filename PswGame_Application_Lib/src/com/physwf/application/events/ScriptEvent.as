package com.physwf.application.events
{
	import flash.events.Event;
	
	public class ScriptEvent extends Event
	{
		public static const SCRIPT_LOADED:String = "script_loaded";
		
		private var mInfo:Object;
		
		public function ScriptEvent(type:String,info:Object)
		{
			super(type, false, false);
			mInfo = info;
		}
		
		public function get info():Object
		{
			return mInfo;
		}
	}
}
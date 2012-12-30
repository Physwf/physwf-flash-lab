package com.physwf.system.events
{
	import flash.events.Event;
	
	public class MapEvent extends Event
	{
		public function MapEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
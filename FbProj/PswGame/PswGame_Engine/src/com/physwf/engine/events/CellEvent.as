package com.physwf.engine.events
{
	import flash.events.Event;
	
	public class CellEvent extends Event
	{
		public function CellEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
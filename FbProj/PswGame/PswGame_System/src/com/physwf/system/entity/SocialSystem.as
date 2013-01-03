package com.physwf.system.entity
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class SocialSystem extends EventDispatcher
	{
		public function SocialSystem(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}
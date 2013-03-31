package com.physwf.engine.loot
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * 物品掉落
	 * @author joe
	 * 
	 */	
	public class Loot extends EventDispatcher
	{
		public function Loot(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}
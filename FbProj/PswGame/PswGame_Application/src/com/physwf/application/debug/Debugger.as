package com.physwf.application.debug
{
	import com.physwf.application.plugin.IPlugin;
	import com.physwf.application.plugin.PluginInfo;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Debugger extends EventDispatcher implements IPlugin
	{
		public function Debugger(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function set info(v:PluginInfo):void
		{
		}
		
		public function execute(root:Sprite):void
		{
		}
		
		public function dispose():void
		{
		}
	}
}
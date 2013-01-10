package com.physwf.application.debug
{
	import com.physwf.application.debug.map.MapDebuger;
	import com.physwf.application.plugin.IPlugin;
	import com.physwf.application.plugin.PluginInfo;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Debugger extends EventDispatcher
	{
		private var mapDebug:MapDebuger;
		
		public function Debugger(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function set info(v:PluginInfo):void
		{
		}
		
		public function execute(root:Sprite):void
		{
			root.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch(e.charCode)
			{
				case Keyboard.M:
					if(!mapDebug)mapDebug = new MapDebuger();
					mapDebug.toggleAstarDebug();
					break;
			}
		}
		
		public function dispose():void
		{
			
		}
		
		public function update():void
		{
			
		}
	}
}
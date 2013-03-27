package com.physwf.application.debug
{
	import com.physwf.application.debug.console.Console;
	import com.physwf.application.debug.map.MapDebuger;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class Debugger extends EventDispatcher
	{
		private var mapDebug:MapDebuger;
		private var mConsole:Console;
		private var mRoot:Sprite;
		
		public function Debugger(root:Sprite)
		{
			mRoot = root;
			root.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode )
			{
				case Keyboard.M:
					if(!e.ctrlKey) return;
					if(!mapDebug)mapDebug = new MapDebuger();
					mapDebug.toggleAstarDebug();
					break;
				case Keyboard.D:
					if(!e.ctrlKey) return;
					mConsole ||= new Console(mRoot);
					mConsole.toogle();
					break;
			}
		}
		
		public function get console():Console
		{
			return mConsole;
		}
		
		public function dispose():void
		{
			
		}
		
		public function update():void
		{
			
		}
	}
}
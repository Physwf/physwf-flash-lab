package com.physwf.application.debug.console
{
	import com.physwf.engine.Engine;
	import com.physwf.system.System;
	import com.physwf.system.entity.MySelf;
	
	import flash.utils.Dictionary;

	public class Command
	{
		private static var cmds:Dictionary;
		private static var mapCmds:Dictionary;
		
		public function Command()
		{
		}
		
		public static function initialize():void
		{
			cmds = new Dictionary();
			mapCmds = new Dictionary();
			
			cmds["map"] = mapCmds;
			
			mapCmds["goto"] = new Command();
		}
		
		public static function parse(rawCmd:String):void
		{
			var codes:Array = rawCmd.split(/\s/);
			var cmdset:Dictionary = cmds[codes[0]];
			if(cmdset)
			{
				Engine.world.switchMap(codes[2],0,0);
			}
		}
	}
}
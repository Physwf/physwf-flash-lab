package com.physwf.engine.script 
{
	import flash.display.Sprite;

	public class MapScriptBase extends Sprite implements IMapScript
	{
		public var npcList:XML;
		
		public function MapScriptBase()
		{
		}
		
		public function initialize():void
		{
		}
		/**
		 * 只负责更新游戏逻辑，如任务，剧情等，不负责渲染 
		 * 
		 */		
		public function update():void
		{
		}
		
		public function destroy():void
		{
		}
	}
}
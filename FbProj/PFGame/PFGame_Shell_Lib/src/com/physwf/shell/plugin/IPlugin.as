package com.physwf.shell.plugin
{
	import com.physwf.shell.interfaces.IDestroyable;
	
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;

	public interface IPlugin extends IDestroyable,IEventDispatcher
	{
		function get info():PluginInfo;
		function set info(v:PluginInfo):void
		function execute(root:Sprite):void;
		/**
		 * 销毁方法应该释放该插件对外部资源的引用 
		 */		
//		function dispose():void;
		function update():void;
	}
}
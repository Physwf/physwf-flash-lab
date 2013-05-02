package com.physwf.shell.plugin
{
	
	import flash.events.Event;

	public class PluginEvent extends Event
	{
		public static const PLUGIN_INSTALLED:String = "plugin_installed";
		public static const PLUGIN_UNINSTALLED:String = "plugin_uninstalled";
		public static const PLUGIN_FINISHED:String = "plugin_finished";
		
		private var mPluginInfo:PluginInfo;
		
		public function PluginEvent(type:String,info:PluginInfo)
		{
			super(type,false,false);
			mPluginInfo = info;
		}
		
		public function get pluginInfo():PluginInfo
		{
			return mPluginInfo;
		}
	}
}
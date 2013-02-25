package
{
	import com.physwf.application.startup.Startup;
	import com.physwf.shell.plugin.IPlugin;
	import com.physwf.shell.plugin.PluginEvent;
	import com.physwf.shell.plugin.PluginInfo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class StartupPlugin extends Sprite implements IPlugin
	{
		private var mStartup:Startup;
		private var mInfo:PluginInfo;
		
		public function StartupPlugin()
		{
			
		}
		
		public function set info(v:PluginInfo):void
		{
			mInfo = v;
		}
		
		public function get info():PluginInfo
		{
			return mInfo;
		}
		
		public function execute(root:Sprite):void
		{
			mStartup = new Startup();
			mStartup.initialize(root);
			mStartup.addEventListener("finished",onPluginFinished);
		}
		
		private function onPluginFinished(e:Event):void
		{
			mStartup.removeEventListener("finished",onPluginFinished);
			dispatchEvent(new PluginEvent(PluginEvent.PLUGIN_FINISHED,mInfo));
		}
		
		public function dispose():void
		{
			mStartup = null;
			mInfo = null;
		}
		
		public function update():void
		{
		}
	}
}
package
{
	import com.physwf.application.plugin.IPlugin;
	import com.physwf.application.plugin.PluginInfo;
	import com.physwf.application.startup.Startup;
	
	import flash.display.Sprite;
	
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
		
		
		public function execute(root:Sprite):void
		{
			mStartup = new Startup();
			mStartup.initialize();
		}
		
		public function dispose():void
		{
			mStartup = null;
			mInfo = null;
		}
		
	}
}
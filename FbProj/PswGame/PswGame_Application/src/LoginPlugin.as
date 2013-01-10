package
{
	import com.physwf.application.login.Login;
	import com.physwf.application.plugin.IPlugin;
	import com.physwf.application.plugin.PluginEvent;
	import com.physwf.application.plugin.PluginInfo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class LoginPlugin extends Sprite implements IPlugin
	{
		private var mLogin:Login;
		private var mInfo:PluginInfo;
		
		public function LoginPlugin()
		{
			super();
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
			mLogin = new Login(root);
			mLogin.initialize();
			mLogin.addEventListener("finished",
				function (e:Event):void 
				{
					dispatchEvent(new PluginEvent(PluginEvent.PLUGIN_FINISHED,mInfo));
				});
		}
		
		public function dispose():void
		{
			mLogin.dispose();
			mLogin = null;
			mInfo = null;
		}
		
		public function update():void
		{
		}
	}
}
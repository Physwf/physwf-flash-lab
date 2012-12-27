package
{
	import com.physwf.application.login.Login;
	import com.physwf.application.plugin.IPlugin;
	import com.physwf.application.plugin.PluginInfo;
	
	import flash.display.Sprite;
	
	public class LoginPlugin extends Sprite implements IPlugin
	{
		private var mLogin:Login;
		private var mInfo:PluginInfo;
		
		public function LoginPlugin()
		{
			super();
		}
		
		public function execute(root:Sprite):void
		{
			mLogin = new Login(root);
			mLogin.initialize();
		}
		
		public function dispose():void
		{
		}
		
		public function get info():PluginInfo
		{
			return null;
		}
	}
}
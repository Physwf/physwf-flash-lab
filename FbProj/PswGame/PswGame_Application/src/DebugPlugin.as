package
{
	import com.physwf.application.debug.Debugger;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.shell.plugin.IPlugin;
	import com.physwf.shell.plugin.PluginInfo;
	
	import flash.display.Sprite;
	
	public class DebugPlugin extends Sprite implements IPlugin, IUpdatable
	{
		private var mInfo:PluginInfo;
		private var debuger:Debugger;
		
		public function DebugPlugin()
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
			debuger = new Debugger(root);
		}
		
		public function dispose():void
		{
		}
		
		public function update():void
		{
		}
	}
}
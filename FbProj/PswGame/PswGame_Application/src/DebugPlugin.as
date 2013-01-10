package
{
	import com.physwf.application.debug.Debugger;
	import com.physwf.application.plugin.IPlugin;
	import com.physwf.application.plugin.PluginInfo;
	import com.physwf.components.interfaces.IUpdatable;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class DebugPlugin extends EventDispatcher implements IPlugin, IUpdatable
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
			debuger = new Debugger();
		}
		
		public function dispose():void
		{
		}
		
		public function update():void
		{
		}
	}
}
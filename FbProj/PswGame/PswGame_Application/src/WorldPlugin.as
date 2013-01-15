package
{
	import com.physwf.application.world.World;
	import com.physwf.shell.plugin.IPlugin;
	import com.physwf.shell.plugin.PluginInfo;
	
	import flash.display.Sprite;
	
	public class WorldPlugin extends Sprite implements IPlugin
	{
		private var world:World;
		private var mInfo:PluginInfo;
		
		public function WorldPlugin()
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
			world = new World();
			world.initialize();
		}
		
		public function dispose():void
		{
		}
		
		public function update():void
		{
			world.update();
		}
	}
}
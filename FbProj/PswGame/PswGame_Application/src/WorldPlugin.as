package
{
	import com.physwf.application.plugin.IPlugin;
	import com.physwf.application.plugin.PluginInfo;
	import com.physwf.application.world.World;
	
	import flash.display.Sprite;
	
	public class WorldPlugin extends Sprite implements IPlugin
	{
		private var world:World;
		
		public function WorldPlugin()
		{
			super();
		}
		
		public function set info(v:PluginInfo):void
		{
		}
		
		public function execute(root:Sprite):void
		{
			world = new World();
			world.initialize();
		}
		
		public function dispose():void
		{
		}
	}
}
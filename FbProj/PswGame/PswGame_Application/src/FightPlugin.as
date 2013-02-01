package
{
	import com.physwf.engine.fight.Fight;
	import com.physwf.shell.plugin.IPlugin;
	import com.physwf.shell.plugin.PluginInfo;
	
	import flash.display.Sprite;
	
	public class FightPlugin extends Sprite implements IPlugin
	{
		private var mInfo:PluginInfo;
		private var mFight:Fight;
		
		public function FightPlugin()
		{
			super();
		}
		
		public function get info():PluginInfo
		{
			return mInfo;
		}
		
		public function set info(v:PluginInfo):void
		{
			mInfo = v;
		}
		
		public function execute(root:Sprite):void
		{
			mFight = new Fight();
			mFight.initialize();
		}
		
		public function update():void
		{
			mFight.update();
		}
		
		public function dispose():void
		{
		}
	}
}
package
{
	import com.physwf.engine.bag.Bag;
	import com.physwf.shell.plugin.IPlugin;
	import com.physwf.shell.plugin.PluginInfo;
	
	import flash.display.Sprite;
	
	public class BagPlugin extends Sprite implements IPlugin
	{
		private var mInfo:PluginInfo;
		private var mBag:Bag;
		
		public function BagPlugin()
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
			mBag = new Bag();
			mBag.initialize();
		}
		
		public function update():void
		{
			mBag.update();
		}
		
		public function dispose():void
		{
		}
	}
}
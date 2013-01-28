package
{
	import com.physwf.engine.frame.Frame;
	import com.physwf.shell.plugin.IPlugin;
	import com.physwf.shell.plugin.PluginInfo;
	
	import flash.display.Sprite;
	
	public class FramePlugin extends Sprite implements IPlugin
	{
		private var mInfo:PluginInfo;
		private var mFrame:Frame;
		
		public function FramePlugin()
		{
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
			mFrame = new Frame();
			mFrame.initialize();
		}
		
		public function update():void
		{
			mFrame.update();
		}
		
		public function dispose():void
		{
		}
	}
}
package
{
	import com.physwf.application.input.Input;
	import com.physwf.shell.plugin.IPlugin;
	import com.physwf.shell.plugin.PluginInfo;
	
	import flash.display.Sprite;

	/**
	 * 输入管理，包括键盘和鼠标 
	 * @author joe
	 * 
	 */	
	public class InputPlugin extends Sprite implements IPlugin
	{
		private var mInput:Input;
		private var mInfo:PluginInfo;
		
		public function InputPlugin()
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
			mInput = new Input(root);
			mInput.initialize();
		}
		
		public function update():void
		{
		}
		
		public function dispose():void
		{
			mInput.dispose();
			mInput = null;
		}
	}
}
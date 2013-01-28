package com.physwf.engine.frame
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.frame.manager.ToolBar;

	public class Frame implements IUpdatable
	{
		private var mToolBar:ToolBar;
		
		public function Frame()
		{
		}
		
		public function initialize():void
		{
			mToolBar = new ToolBar();
		}
		
		public function update():void
		{
			mToolBar.update();
		}
		
	}
}
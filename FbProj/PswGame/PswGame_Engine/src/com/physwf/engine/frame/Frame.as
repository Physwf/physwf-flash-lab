package com.physwf.engine.frame
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.components.ui.DragManager;
	import com.physwf.components.ui.IconLoader;
	import com.physwf.engine.Engine;
	import com.physwf.engine.frame.manager.SkillBar;
	import com.physwf.engine.frame.manager.ToolBar;
	
	import flash.events.EventDispatcher;

	public class Frame extends EventDispatcher implements IUpdatable
	{
		private var mToolBar:ToolBar;
		private var mSkillBar:SkillBar;
		
		public function Frame()
		{
		}
		
		public function initialize():void
		{
			Engine.frame = this;
			
			IconLoader.iconDir = "resource/icons/";
			DragManager.instance = new DragManager(ScreenManager.main.tip);
			
			mToolBar = new ToolBar();
			mToolBar.enableListeners();
			
			mSkillBar = new SkillBar();
		}
		
		public function update():void
		{
			mToolBar.update();
			mSkillBar.update();
			DragManager.instance.update();
		}
		
	}
}
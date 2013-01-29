package com.physwf.engine.frame
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.engine.Engine;
	import com.physwf.engine.frame.manager.SkillBar;
	import com.physwf.engine.frame.manager.ToolBar;

	public class Frame implements IUpdatable
	{
		private var mToolBar:ToolBar;
		private var mSkillBar:SkillBar;
		
		public function Frame()
		{
		}
		
		public function initialize():void
		{
			mToolBar = new ToolBar();
			mToolBar.enableListeners();
			
			mSkillBar = new SkillBar();
			
			Engine.frame = this;
		}
		
		public function update():void
		{
			mToolBar.update();
			mSkillBar.update();
		}
		
	}
}
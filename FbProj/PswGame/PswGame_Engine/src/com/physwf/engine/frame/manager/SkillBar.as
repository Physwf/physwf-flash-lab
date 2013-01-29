package com.physwf.engine.frame.manager
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.components.ui.factory.BarFactory;
	import com.physwf.components.ui.layout.HBar;
	import com.physwf.engine.frame.config.FrameAssets;
	
	public class SkillBar implements IUpdatable
	{
		private var barFactroy:BarFactory;
		
		private var view:HBar;
		
		public function SkillBar()
		{
			barFactroy = new BarFactory();
			view = barFactroy.createHBar(FrameAssets.SKILL_BAR);
			ScreenManager.main.frame.addChild(view);
			view.x = 100;
			view.y = 540;
		}
		
		public function update():void
		{
			view.update();
		}
	}
}
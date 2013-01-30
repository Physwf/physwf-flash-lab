package com.physwf.engine.frame.manager
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.components.ui.config.CellConfig;
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.components.ui.factory.BarFactory;
	import com.physwf.components.ui.factory.CellFactory;
	import com.physwf.components.ui.factory.FactoryManager;
	import com.physwf.components.ui.layout.HBar;
	import com.physwf.engine.frame.config.FrameAssets;
	import com.physwf.engine.frame.view.SkillBarView;
	
	public class SkillBar implements IUpdatable
	{
		private var view:SkillBarView;
		
		public function SkillBar()
		{
			view = new SkillBarView();
			view.x = 100;
			view.y = 540;
			ScreenManager.main.frame.addChild(view);
		}
		
		public function update():void
		{
			view.update();
		}
	}
}
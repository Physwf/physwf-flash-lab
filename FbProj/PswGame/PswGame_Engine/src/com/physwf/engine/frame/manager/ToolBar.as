package com.physwf.engine.frame.manager
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.components.ui.config.ButtonConfig;
	import com.physwf.components.ui.controls.Button;
	import com.physwf.components.ui.factory.ButtonFactory;
	import com.physwf.engine.frame.config.AssetsConfig;

	public class ToolBar implements IUpdatable
	{
		private var btnFactory:ButtonFactory;
		
		private var mRole:Button;
		private var mBag:Button;
		private var mSkill:Button;
		
		public function ToolBar()
		{
			btnFactory = new ButtonFactory();
			
			var config:ButtonConfig = AssetsConfig.BTN_ROLE;
			mRole = btnFactory.createButton(config);
			mRole.x = config.x;
			mRole.y = config.y;
			
			config = AssetsConfig.BTN_BAG;
			mBag = btnFactory.createButton(config);
			mBag.x = config.x;
			mBag.y = config.y;
			
			config = AssetsConfig.BTN_SKILL;
			mSkill = btnFactory.createButton(config);
			mSkill.x = config.x;
			mSkill.y = config.y;
			
			ScreenManager.main.frame.addChild(mRole);
			ScreenManager.main.frame.addChild(mBag);
			ScreenManager.main.frame.addChild(mSkill);
		}
		
		public function update():void
		{
			mRole.update();
			mBag.update();
			mSkill.update();
		}
	}
}
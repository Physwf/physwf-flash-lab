package com.physwf.engine.frame.manager
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.screen.Layer;
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.components.ui.config.ButtonConfig;
	import com.physwf.components.ui.controls.Button;
	import com.physwf.components.ui.factory.ButtonFactory;
	import com.physwf.engine.Engine;
	import com.physwf.engine.frame.config.FrameAssets;
	
	import flash.events.MouseEvent;

	public class ToolBar implements IUpdatable
	{
		private var btnFactory:ButtonFactory;
		
		private var mRole:Button;
		private var mBag:Button;
		private var mSkill:Button;
		
		public function ToolBar()
		{
			btnFactory = new ButtonFactory();
			
			var config:ButtonConfig = FrameAssets.BTN_ROLE;
			mRole = btnFactory.createButton(config);
			mRole.x = config.x;
			mRole.y = config.y;
			
			config = FrameAssets.BTN_BAG;
			mBag = btnFactory.createButton(config);
			mBag.x = config.x;
			mBag.y = config.y;
			
			config = FrameAssets.BTN_SKILL;
			mSkill = btnFactory.createButton(config);
			mSkill.x = config.x;
			mSkill.y = config.y;
			
			ScreenManager.main.frame.addChild(mRole);
			ScreenManager.main.frame.addChild(mBag);
			ScreenManager.main.frame.addChild(mSkill);
		}
		
		public function enableListeners():void
		{
			mRole.addEventListener(MouseEvent.CLICK,onMouseClick);
			mBag.addEventListener(MouseEvent.CLICK,onMouseClick);
			mSkill.addEventListener(MouseEvent.CLICK,onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			var frameLayer:Layer = ScreenManager.main.frame;
			switch(e.target)
			{
				case mRole:
					break;
				case mBag:
					Engine.bag.toggle(frameLayer);
					break;
				case mSkill:
					break;
			}
		}
		
		public function update():void
		{
			mRole.update();
			mBag.update();
			mSkill.update();
		}
	}
}
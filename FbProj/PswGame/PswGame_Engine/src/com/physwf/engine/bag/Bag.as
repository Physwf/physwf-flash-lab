package com.physwf.engine.bag
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.config.PanelConfig;
	import com.physwf.components.ui.factory.PanelFactory;
	import com.physwf.components.ui.layout.IPopup;
	import com.physwf.components.ui.layout.Panel;
	import com.physwf.engine.Engine;
	import com.physwf.engine.bag.config.BagAssets;
	
	import flash.display.DisplayObjectContainer;
	
	public class Bag implements IUpdatable,IPopup
	{
		private var pFactory:PanelFactory;
		
		private var mBagView:Panel;
		
		public function Bag()
		{
			pFactory = new PanelFactory();
		}
		
		public function initialize():void
		{
			var config:PanelConfig = BagAssets.PANEL_BAG;
			mBagView = pFactory.createPanel(config);
			mBagView.x = 500;
			mBagView.y = 100;
			Engine.bag = this;
		}
		
		public function update():void
		{
			mBagView.update();
		}
		
		public function hide():void
		{
			mBagView.hide();
		}
		
		public function show($parent:DisplayObjectContainer):void
		{
			mBagView.show($parent);
		}
		
		public function toggle($parent:DisplayObjectContainer):void
		{
			mBagView.toggle($parent);
		}
	}
}
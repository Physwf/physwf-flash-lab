package com.physwf.engine.bag
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.config.PanelConfig;
	import com.physwf.components.ui.factory.PanelFactory;
	import com.physwf.components.ui.layout.IPopup;
	import com.physwf.components.ui.layout.Panel;
	import com.physwf.engine.Engine;
	import com.physwf.engine.bag.config.BagAssets;
	import com.physwf.engine.bag.view.BagView;
	
	import flash.display.DisplayObjectContainer;
	
	public class Bag implements IUpdatable,IPopup
	{
		private var mBagView:BagView;
		
		public function Bag()
		{
			mBagView = new BagView();
			mBagView.x = 620;
			mBagView.y = 60;
		}
		
		public function initialize():void
		{
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
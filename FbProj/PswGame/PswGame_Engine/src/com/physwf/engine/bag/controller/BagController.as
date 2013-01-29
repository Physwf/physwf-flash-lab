package com.physwf.engine.bag.controller
{
	import com.physwf.engine.bag.view.BagView;
	
	import flash.events.MouseEvent;

	public class BagController
	{
		public function BagController()
		{
		}
		
		public function initialize(view:BagView):void
		{
			view.addEventListener(MouseEvent.CLICK,onBagClick);
		}
		
		private function onBagClick(e:MouseEvent):void
		{
			
		}
	}
}
package com.physwf.engine.frame.controller
{
	import com.physwf.engine.frame.view.SkillBarView;
	
	import flash.events.MouseEvent;

	public class SkillBarController
	{
		public function SkillBarController()
		{
		}
		
		public function initialize(view:SkillBarView):void
		{
			view.addEventListener(MouseEvent.CLICK,onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			
		}
	}
}
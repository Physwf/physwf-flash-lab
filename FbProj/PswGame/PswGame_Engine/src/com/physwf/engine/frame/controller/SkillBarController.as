package com.physwf.engine.frame.controller
{
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.engine.Engine;
	import com.physwf.engine.frame.config.FrameAssets;
	import com.physwf.engine.frame.view.SkillBarView;
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

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
			var cell:Cell = e.target as Cell;
			if(cell)
			{
				Engine.challenge.selectSill = cell.data as SkillInfo;
				cell.startCd();
//				Mouse.cursor = FrameAssets.CURSOR_AIM_NAME;
			}
		}
	}
}
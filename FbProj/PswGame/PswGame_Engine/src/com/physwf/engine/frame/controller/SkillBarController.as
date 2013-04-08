package com.physwf.engine.frame.controller
{
	import com.physwf.components.ui.DragManager;
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.events.CellEvent;
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
			Engine.frame.addEventListener(CellEvent.CELL_CLICKED,onCellEvent);
			Engine.frame.addEventListener(CellEvent.CELL_PRESSED,onCellEvent);
			Engine.frame.addEventListener(CellEvent.CELL_RELEASED,onCellEvent);
		}
		
		private function onCellEvent(e:CellEvent):void
		{
			var cell:Cell = e.cell;
			switch(e.type)
			{
				case CellEvent.CELL_CLICKED:
					Engine.challenge.selectSill = cell.data as SkillInfo;
					cell.startCd();
					break;
				case CellEvent.CELL_PRESSED:
					DragManager.instance.dragItem = cell.content.bitmapData.clone();
					break;
				case CellEvent.CELL_RELEASED:
					cell.contentData = DragManager.instance.dragItem;
					break;
			}
			if(cell)
			{
//				Mouse.cursor = FrameAssets.CURSOR_AIM_NAME;
			}
		}
	}
}
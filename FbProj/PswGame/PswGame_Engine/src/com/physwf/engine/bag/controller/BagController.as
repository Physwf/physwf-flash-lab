package com.physwf.engine.bag.controller
{
	import com.physwf.components.ui.DragManager;
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.engine.Engine;
	import com.physwf.engine.bag.view.BagView;
	import com.physwf.engine.common.events.CellEvent;
	
	import flash.events.MouseEvent;

	public class BagController
	{
		public function BagController()
		{
		}
		
		public function initialize(view:BagView):void
		{
			Engine.bag.addEventListener(CellEvent.CELL_PRESSED,onCellEvent);
			Engine.bag.addEventListener(CellEvent.CELL_CLICKED,onCellEvent);
			Engine.bag.addEventListener(CellEvent.CELL_RELEASED,onCellEvent);
		}
		
		private function onCellEvent(e:CellEvent):void
		{
			var cell:Cell = e.cell;
			switch(e.type)
			{
				case CellEvent.CELL_CLICKED:
					break;
				case CellEvent.CELL_PRESSED:
					DragManager.instance.dragItem = cell.content.bitmapData.clone();
					break;
				case CellEvent.CELL_RELEASED:
					cell.contentData = DragManager.instance.dragItem;
					break;
			}
		}
	}
}
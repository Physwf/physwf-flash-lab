package com.physwf.engine.bag.controller
{
	import com.physwf.components.ui.DragManager;
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.engine.Engine;
	import com.physwf.engine.bag.view.BagView;
	import com.physwf.engine.common.events.CellEvent;
	
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class BagController
	{
		private var cellDraged:Cell;
		private var timeout:uint;
		
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
			// to do 重新考虑拖拽
			var cell:Cell = e.cell;
			switch(e.type)
			{
				case CellEvent.CELL_CLICKED:
					break;
				case CellEvent.CELL_PRESSED:
					if(cell.data == null) return;
					cellDraged = cell;
					timeout = setTimeout(function():void
					{
						DragManager.instance.dragItem = cell.content.bitmapData.clone();
						DragManager.instance.dragInfo = cell.data;
					},100);
					break;
				case CellEvent.CELL_RELEASED:
					clearTimeout(timeout);
					if(cellDraged && cell != cellDraged)
					{
						cell.contentData = DragManager.instance.dragItem;
						cell.data = DragManager.instance.dragInfo;
						cellDraged.contentData=null;
					}
					cellDraged = null;
					DragManager.instance.dragItem = null;
					DragManager.instance.dragInfo = null;
					break;
			}
		}
	}
}
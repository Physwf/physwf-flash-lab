package com.physwf.engine.common
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.DragManager;
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.engine.Engine;
	import com.physwf.engine.common.events.CellEvent;
	import com.physwf.system.vo.SkillInfo;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * cell manager 
	 * @author joe
	 * 
	 */	
	public class CM extends EventDispatcher implements IUpdatable
	{
		private var timeout:uint;
		private var mSkillCells:Vector.<Cell>;
		private var mBagCells:Vector.<Cell>;
		
		public function CM()
		{
			
		}
		
		public function initialize():void
		{
			mSkillCells = new Vector.<Cell>();
			mBagCells = new Vector.<Cell>();
			addEventListener(CellEvent.CELL_CLICKED,onCellEvent);
			addEventListener(CellEvent.CELL_PRESSED,onCellEvent);
			addEventListener(CellEvent.CELL_RELEASED,onCellEvent);
		}
		
		public function addSkillCell(cell:Cell):Cell
		{
			mSkillCells.push(cell);
			return cell;
		}
		
		public function addBagCell(cell:Cell):Cell
		{
			mBagCells.push(cell);
			return cell;
		}
		
		public function getBagCell(grid:uint):Cell
		{
			return mBagCells[grid];
		}
		
		private function onCellEvent(e:CellEvent):void
		{
			var cell:Cell = e.cell;
			switch(e.type)
			{
				case CellEvent.CELL_CLICKED:
					if(cell.data == null) return;
					if(cell.location == Cell.LOCATION_SKILLBAR)
					{
						Engine.challenge.selectSill = cell.data as SkillInfo;
						executeCD(cell.data);
					}
					else if(cell.location == Cell.LOCATION_BAG)
					{
						
					}
					break;
				case CellEvent.CELL_PRESSED:
					if(cell.data == null) return;
					timeout = setTimeout(function():void
					{
						DragManager.instance.cellDraged = cell;
						DragManager.instance.dragItem = cell.content.bitmapData;
						DragManager.instance.dragInfo = cell.data;
					},500);
					break;
				case CellEvent.CELL_RELEASED:
					clearTimeout(timeout);
					if(DragManager.instance.cellDraged && cell != DragManager.instance.cellDraged)
					{
						cell.contentData = DragManager.instance.dragItem;
						cell.data = DragManager.instance.dragInfo;
					}
					DragManager.instance.cellDraged = null;
					DragManager.instance.dragItem = null;
					DragManager.instance.dragInfo = null;
					break;
			}
		}
		
		private function executeCD(data:*):void
		{
			var cell:Cell;
			for each(cell in mSkillCells)
			{
				if(cell.data == data)
				{
					cell.startCd();
				}
				else
				{
					cell.startShareCd();
				}
			}
			for each(cell in mBagCells)
			{
				if(cell.data == data)
				{
					cell.startCd();
				}
				else if(cell.cdTime>0)
				{
					cell.startShareCd();
				}
			}
		}
		
		public function update():void
		{
			for(var i:uint=0;i<mSkillCells.length;++i)
			{
				mSkillCells[i].update();
			}
			for(i=0;i<mBagCells.length;++i)
			{
				mBagCells[i].update();
			}
		}
	}
}
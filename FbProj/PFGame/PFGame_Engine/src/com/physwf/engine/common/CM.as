package com.physwf.engine.common
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.engine.common.events.CellEvent;
	
	import flash.events.EventDispatcher;

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
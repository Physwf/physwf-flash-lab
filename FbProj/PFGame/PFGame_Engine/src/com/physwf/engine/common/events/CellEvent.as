package com.physwf.engine.common.events
{
	import com.physwf.components.ui.controls.Cell;
	
	import flash.events.Event;
	
	public class CellEvent extends Event
	{
		public static const CELL_PRESSED:String = "c_p";
		public static const CELL_RELEASED:String = "c_r";
		public static const CELL_CLICKED:String = "c_c";
		
		private var mCell:Cell;
		
		public function CellEvent(type:String,cell:Cell)
		{
			mCell = cell;
			super(type, false, false);
		}
		
		public function get cell():Cell
		{
			return mCell;
		}
	}
}
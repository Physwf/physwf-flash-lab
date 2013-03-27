package shinater.swing{
	import flash.display.DisplayObject;
	
	public interface IDataGridCellRenderer extends ICellRenderer{
		
		function setColumn(column:int):void;
		
		function getColumn():int;
		
		function setRow(row:int):void;
		
		function getRow():int;
		
		function setEditable(editable:Boolean):void;
		
		function getEditable():Boolean;
	}

}

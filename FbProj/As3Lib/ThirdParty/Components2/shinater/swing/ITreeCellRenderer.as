package shinater.swing{
	import flash.display.DisplayObject;
	
	public interface ITreeCellRenderer extends ICellRenderer{
		
		function setOpenIcon(icon:DisplayObject):void;
		
		function getOpenIcon():DisplayObject;
		
		function setClosedIcon(icon:DisplayObject):void;
		
		function getClosedIcon():DisplayObject;
		
		function setLeafIcon(icon:DisplayObject):void;
		
		function getLeafIcon():DisplayObject;
		
		function setDepth(depth:int):void;
		
		function getDepth():int;
		
		function setIsBranch(isBranch:Boolean):void;
		
		function getIsBranch():Boolean;
		
				
				
		function setIsOpen(open:Boolean):void;
		
		function getIsOpen():Boolean;
	}

}

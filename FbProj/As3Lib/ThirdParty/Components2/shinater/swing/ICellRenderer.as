package shinater.swing{
	import flash.display.DisplayObject;
	
	public interface ICellRenderer {
		
		function setOwner(component:Component):void;
		
		function getOwner():Component;
		
		function setLabel(label:String):void;
		
		function getLabel():String;
		
		function setIcon(icon:DisplayObject):void;
		
		function getIcon():DisplayObject;
		
		
		
		function setData(data:Object):void;
		
		function getData():Object;
		
		function setIndex(index:int):void;
		
		function getIndex():int;
		
		
		
		
		function setSize(width:Number,height:Number):void;
		
		
		
		function setSelected(selected:Boolean):void;
		
		function getSelected():Boolean;
	}

}

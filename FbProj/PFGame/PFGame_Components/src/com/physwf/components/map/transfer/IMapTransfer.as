package com.physwf.components.map.transfer {

	public interface IMapTransfer {

		function gotoMap(id:int, type:uint, x:Number, y:Number):void;
		function transferTo(x:Number, y:Number):void;
		function get mapID():int;
		function get mapType():uint;

	} // end interface
} // end package
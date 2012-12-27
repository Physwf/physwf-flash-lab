package com.physwf.components.map.layer.depth {
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public class DepthElement {

		public var depth:uint;

		public var view:DisplayObject;

		private var _rectTop:Point;

		private var _rectBottom:Point;

		public var isoTop:Point;

		public var isoBottom:Point;


		public function DepthElement() {
		}

		public function set rectTop(v:Point):void {
		}

		public function set rectBottom(v:Point):void {
		}

	} // end class
} // end package
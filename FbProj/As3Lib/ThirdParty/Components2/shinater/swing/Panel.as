package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class Panel extends Container implements IScrollable {
		protected var _width:Number;
		protected var _height:Number;
		
		public var skin:Sprite;
				
		public function Panel() {
			super();
		}
		protected override function init():void {
			_width = super.width;
			_height = super.height;
			scaleX = scaleY = 1;
			super.init();
			repaint();
		}
		
		public override function get width():Number{
			return _width;
		}
		public override function set width(value:Number):void {
			if (_width == value) {
				return;
			}
			_width = value;
			repaint();
			dispatchEvent(new Event(Event.RESIZE,false));
		}
		
		public override function get height():Number{
			return _height;
		}
		public override function set height(value:Number):void {
			if (_height == value) {
				return;
			}
			_height = value;
			repaint();
			dispatchEvent(new Event(Event.RESIZE,false));
		}
		public override function setSize(width:Number, height:Number):void {
			if (_width == width && _height == height) {
				return;
			}
			_width = width;
			_height = height;
			repaint();
			dispatchEvent(new Event(Event.RESIZE,false));
		}
		public override function addChild(child:DisplayObject):DisplayObject {
			return addChildAt(child, numChildren);
		}
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject {
			var _1:Number = width;
			var _2:Number = height;
			if(child.root != null && root != null){
				var _3:Point = child.parent.localToGlobal(new Point(child.x,child.y));
				_3 = globalToLocal(_3);
				child.x = _3.x;
				child.y = _3.y;
			}
			child = super.addChildAt(child,index);
			if (_1 != width || _2 != height) {
				dispatchEvent(new Event(Event.RESIZE,false));
			}
			return child;
		}
		public override function removeChild(child:DisplayObject):DisplayObject {
			return removeChildAt(getChildIndex(child));
		}
		public override function removeChildAt(index:int):DisplayObject {
			var _1:Number = width;
			var _2:Number = height;
			var _3:DisplayObject = super.removeChildAt(index);
			if (_1 != width || _2 != height) {
				dispatchEvent(new Event(Event.RESIZE,false));
			}
			return _3;
		}
		
		public function setOpaque(opaque:Boolean):void {
			if (skin == null) {
				return;
			}
			skin.alpha = opaque ? 1:0;
		}
		
		public function getOpaque():Boolean {
			return skin != null ? skin.alpha == 1:false;
		}
		
		public function setViewport(viewport:Rectangle):void {
			scrollRect = viewport;
		}
		
		public function getViewport():Rectangle {
			return scrollRect;
		}
		
		
		
		
		[Event(name = "resize",type = "flash.events.Event")]
		
		
		
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _1:Number = _width;
			var _2:Number = _height;
			if(skin != null){
				skin.width = _1;
				skin.height = _2;
			}
			if(super.width > _1 || super.height > _2 || scrollRect != null){
				var _3:Rectangle = scrollRect != null ? scrollRect : new Rectangle();
				_3.width = _1;
				_3.height = _2;
				scrollRect = _3;
			}
		}
	}
}

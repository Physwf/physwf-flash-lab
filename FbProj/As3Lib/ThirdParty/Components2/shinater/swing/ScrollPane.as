package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.geom.Transform;
	import shinater.swing.managers.StyleManager;

	
	public dynamic class ScrollPane extends Container {
				private var _1:String = "auto";
				private var _2:String = "auto";
		private var _3:Boolean = false;
				private var _4:DisplayObject;
		protected var _hLineScrollSize:Number = 5;
		protected var _vLineScrollSize:Number = 5;
		protected var _hPageScrollSize:Number = 0;
		protected var _vPageScrollSize:Number = 0;
		protected var _width:Number;
		protected var _height:Number;
		protected var _contentPaddingX:Number = 1;
		protected var _contentPaddingY:Number = 1;
		
		public var skin:Sprite;
				
		public var horizontalScrollBar:ScrollBar;
		
		public var verticalScrollBar:ScrollBar;
		
		public function ScrollPane() {
			super();
		}
		protected override function init():void {
			_width = super.width;
			_height = super.height;
			scaleX = scaleY = 1;
			super.init();
			setHorizontalLineScrollSize(_hLineScrollSize);
			setVerticalLineScrollSize(_vLineScrollSize);
			horizontalScrollBar.setOrientation(ScrollBar.HORIZONTAL);
			horizontalScrollBar.addEventListener(Event.SCROLL,onScroll,false,0,true);
			verticalScrollBar.addEventListener(Event.SCROLL,onScroll,false,0,true);
			_contentPaddingX = horizontalScrollBar.x;
			_contentPaddingY = verticalScrollBar.y;
			setWheelScrollingEnabled(true);
			addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
			repaint();
		}
		public override function set width(value:Number):void {
			if(_width == value){
				return;
			}
			_width = value;
			repaint();
		}
		public override function get width():Number {
			return _width;
		}
		public override function set height(value:Number):void {
			if(_height == value){
				return;
			}
			_height = value;
			repaint();
		}
		public override function get height():Number {
			return _height;
		}
		public override function setSize(width:Number, height:Number):void {
			if(_width == width && _height == height){
				return;
			}
			_width = width;
			_height = height;
			repaint();
		}
		
		public function setContent(content:DisplayObject):void {
			if (_4 != null) {
				_4.removeEventListener(Event.RESIZE, onContentResize);
				removeChild(_4);
			}
			content.addEventListener(Event.RESIZE,onContentResize,false,0,true);
			content.x = _contentPaddingX;
			content.y = _contentPaddingY;
			addChild(content);
			_4 = content;
			repaint();
		}
		
		public function getContent():DisplayObject {
			return _4;
		}
		
		
		
		public function setHorizontalLineScrollSize(lineSize:Number):void {
			_hLineScrollSize = lineSize;
			horizontalScrollBar.setLineScrollSize(lineSize);
		}
		
		public function getHorizontalLineScrollSize():Number {
			return horizontalScrollBar.getLineScrollSize();
		}
		
		
		
		public function setHorizontalPageScrollSize(pageSize:Number):void {
			_hPageScrollSize = pageSize;
			horizontalScrollBar.setPageScrollSize(pageSize);
		}
		
		public function getHorizontalPageScrollSize():Number {
			return horizontalScrollBar.getPageScrollSize();
		}
		
		
		
		public function setHorizontalScrollPosition(position:Number):void {
			var _5:DisplayObject = getContent();
			if (_5 == null || _5.scrollRect == null) {
				return;
			}
			horizontalScrollBar.setScrollPosition(position);
		}
		
		public function getHorizontalScrollPosition():Number {
			return horizontalScrollBar.getScrollPosition();
		}
		
		
		
		public function setHorizontalScrollPolicy(policy:String):void {
			_1 = policy;
			repaint();
		}
		
		public function getHorizontalScrollPolicy():String {
			return _1;
		}
		
		public function getMaxHorizontalScrollPosition():Number {
			return horizontalScrollBar.getMaxScrollPosition();
		}
		
		
		
		public function setVerticalLineScrollSize(lineSize:Number):void {
			_vLineScrollSize = lineSize;
			verticalScrollBar.setLineScrollSize(lineSize);
		}
		
		public function getVerticalLineScrollSize():Number {
			return verticalScrollBar.getLineScrollSize();
		}
		
		
		
		public function setVerticalPageScrollSize(pageSize:Number):void {
			_vPageScrollSize = pageSize;
			verticalScrollBar.setPageScrollSize(pageSize);
		}
		
		public function getVerticalPageScrollSize():Number {
			return verticalScrollBar.getPageScrollSize();
		}
		
		
		
		public function setVerticalScrollPosition(position:Number):void {
			var _5:DisplayObject = getContent();
			if (_5 == null || _5.scrollRect == null) {
				return;
			}
			verticalScrollBar.setScrollPosition(position);
		}
		
		public function getVerticalScrollPosition():Number {
			return verticalScrollBar.getScrollPosition();
		}
		
		
		
		public function setVerticalScrollPolicy(policy:String):void {
			_2 = policy;
			repaint();
		}
		
		public function getVerticalScrollPolicy():String {
			return _2;
		}
		
		public function getMaxVerticalScrollPosition():Number {
			return verticalScrollBar.getMaxScrollPosition();
		}
		
		public function setWheelScrollingEnabled(handleWheel:Boolean):void {
			if(_3 == handleWheel){
				return;
			}
			if (handleWheel) {
				addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel,false,0,true);
			} else {
				removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			}
			_3 = handleWheel;
		}
		
		public function getWheelScrollingEnabled():Boolean {
			return _3;
		}
		protected function onContentResize(evt:Event):void{
			repaint();
		}
		
		[Event(name = "scroll",type = "flash.events.Event")]
		protected function onScroll(evt:Event):void {
			var _5:DisplayObject = getContent();
			var _6:Rectangle = _5.scrollRect;
			if (evt.currentTarget == verticalScrollBar) {
				var _7:int = verticalScrollBar.getScrollPosition();
				_6.y = _7;
			} else if (evt.currentTarget == horizontalScrollBar) {
				var _8:int = horizontalScrollBar.getScrollPosition();
				_6.x = _8;
			}
			_5.scrollRect = _6;
		}
		protected function onMouseWheel(evt:MouseEvent):void {
			if (verticalScrollBar.getEnabled()) {
				verticalScrollBar.setScrollPosition(verticalScrollBar.getScrollPosition() - Math.abs(evt.delta)/evt.delta*verticalScrollBar.getLineScrollSize());
			} else if (horizontalScrollBar.getEnabled()) {
				horizontalScrollBar.setScrollPosition(horizontalScrollBar.getScrollPosition() - Math.abs(evt.delta)/evt.delta*horizontalScrollBar.getLineScrollSize());
			}
		}
		protected function onKeyDown(evt:KeyboardEvent):void {
			if (verticalScrollBar.getEnabled()) {
				var _5:Number = verticalScrollBar.getScrollPosition();
				var _6:Number = verticalScrollBar.getLineScrollSize();
				var _7:Number = verticalScrollBar.getPageScrollSize();
				var _8:Number = verticalScrollBar.getMinScrollPosition();
				var _9:Number = verticalScrollBar.getMaxScrollPosition();
				switch (evt.keyCode) {
					case Keyboard.UP :
						_5 -=  _6;
						break;
					case Keyboard.DOWN :
						_5 +=  _6;
						break;
					case Keyboard.PAGE_UP :
						_5 -=  _7;
						break;
					case Keyboard.PAGE_DOWN :
						_5 +=  _7;
						break;
					case Keyboard.HOME :
						_5 = _8;
						break;
					case Keyboard.END :
						_5 = _9;
				}
				_5 = Math.max(_8,Math.min(_9,_5));
				if (_5 != verticalScrollBar.getScrollPosition()) {
					verticalScrollBar.setScrollPosition(_5);
					return;
				}
			}
			if (horizontalScrollBar.getEnabled()) {
				var _10:Number = horizontalScrollBar.getScrollPosition();
				var _11:Number = horizontalScrollBar.getLineScrollSize();
				if (evt.keyCode == Keyboard.LEFT) {
					if (_10 > horizontalScrollBar.getMinScrollPosition()) {
						horizontalScrollBar.setScrollPosition(_10 - _11);
					}
				} else if (evt.keyCode == Keyboard.RIGHT) {
					if (_10 < horizontalScrollBar.getMaxScrollPosition()) {
						horizontalScrollBar.setScrollPosition(_10 + _11);
					}
				}
			}
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _5:Number = _width;
			var _6:Number = _height;
			skin.width = _5;
			skin.height = _6;
			horizontalScrollBar.visible = _1 == "on";
			verticalScrollBar.visible = _2 == "on";
			var _7:Number = _5 - _contentPaddingX * 2;
			var _8:Number = _6 - _contentPaddingY * 2;
			var _9:DisplayObject = getContent();
			if (_9 != null) {
												_contentPaddingX = _9.x;
				_contentPaddingY = _9.y;
				var _10:Number = _7 - verticalScrollBar.width;
				var _11:Number = _8 - horizontalScrollBar.height;
				var _12:Rectangle = new Rectangle(0,0,verticalScrollBar.visible ? _10:_7,horizontalScrollBar.visible ? _11:_8);
				var _13:Number,_14:Number;
				if(_9.scrollRect == null || stage == null){
					_13 = _9.width;
					_14 = _9.height;
				}else{
					var _15:Transform = _9.transform;
					var _16:Rectangle;
					if(stage.scaleMode == StageScaleMode.NO_SCALE){
						_16 = _15.pixelBounds;
					}else{
						var _17:Matrix = _15.matrix;
						var _18:Matrix = _15.concatenatedMatrix;
						_18.invert();
						_15.matrix = _18;
						_16 = _15.pixelBounds;
						_15.matrix = _17;
					}
					_13 = _16.width;
					_14 = _16.height;
				}
				if (_1 == "auto" && _13 > _12.width) {
					horizontalScrollBar.visible = true;
					_12.height = _11;
				}
				if (_2 == "auto" && _14 > _12.height) {
					verticalScrollBar.visible = true;
					_12.width = _10;
					if (_1 == "auto" && ! horizontalScrollBar.visible && _13 > _12.width) {
						horizontalScrollBar.visible = true;
						_12.height = _11;
					}
				}
				if (_13 <= _12.width && _14 <= _12.height) {
					_9.scrollRect = null;
					horizontalScrollBar.setEnabled(false);
					verticalScrollBar.setEnabled(false);
				} else {
					horizontalScrollBar.setMaxScrollPosition(Math.max(0,_13 - _12.width));
					verticalScrollBar.setMaxScrollPosition(Math.max(0,_14 - _12.height));
					if (_9.scrollRect != null) {
						_12.x = Math.min(_9.scrollRect.x,horizontalScrollBar.getMaxScrollPosition());
						_12.y = Math.min(_9.scrollRect.y,verticalScrollBar.getMaxScrollPosition());
					}
					_9.scrollRect = _12;
					if (_13 > _12.width) {
						horizontalScrollBar.setEnabled(true);
						if (_hPageScrollSize <= 0) {
							horizontalScrollBar.setPageScrollSize(_12.width);
						}
						horizontalScrollBar.setScrollPosition(_12.x);
					} else {
						horizontalScrollBar.setEnabled(false);
					}
					if (_14 > _12.height) {
						verticalScrollBar.setEnabled(true);
						if (_vPageScrollSize <= 0) {
							verticalScrollBar.setPageScrollSize(_12.height);
						}
						verticalScrollBar.setScrollPosition(_12.y);
					} else {
						verticalScrollBar.setEnabled(false);
					}
				}
			} else {
				horizontalScrollBar.setEnabled(false);
				verticalScrollBar.setEnabled(false);
			}
						horizontalScrollBar.y = _6 - _contentPaddingY - horizontalScrollBar.height;
			verticalScrollBar.x = _5 - _contentPaddingX - verticalScrollBar.width;
			if (horizontalScrollBar.visible && verticalScrollBar.visible) {
				horizontalScrollBar.width = _7 - verticalScrollBar.width;
				verticalScrollBar.height = _8 - horizontalScrollBar.height;
			} else if (horizontalScrollBar.visible) {
				horizontalScrollBar.width = _7;
			} else if (verticalScrollBar.visible) {
				verticalScrollBar.height = _8;
			}
		}
	}
}

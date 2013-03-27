package shinater.swing{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import flash.ui.Mouse;
	import flash.geom.Rectangle;
	import shinater.swing.managers.StyleManager;

	
	public dynamic class ScrollBar extends Component {
		
		public static const VERTICAL:String = "vertical";
		
		public static const HORIZONTAL:String = "horizontal";
		private var _1:String = VERTICAL;
		private var _2:Number = 0;
		private var _3:Number = 100;
		private var _4:Number = 0;
		private var _5:Number = 1;
		private var _6:Number = 10;
		private var _7:uint;
		private var _8:String;
		private var _9:int;
		protected var _width:Number;
		protected var _height:Number;
		
		private var _10:Number;
		
		public var upArrow:Button;
		
		public var downArrow:Button;
		
		public var thumb:Button;
				
		public var trackSkin:Sprite;
				
		public var repeatDelay:Number = 500;
		
		public var repeatInterval:Number = 50;
		
		public function ScrollBar() {
			super();
		}
		protected override function init():void {
			if (rotation == 90) {
				_1 = HORIZONTAL;
				_width = super.height;
				_height = super.width;
			}else{
				_width = super.width;
				_height = super.height;
			}
			scaleX = scaleY = 1;
			super.init();
			upArrow.tabEnabled = false;
			upArrow.setFocusEnabled(false);
			upArrow.addEventListener(MouseEvent.MOUSE_DOWN,onScrollArrowDown,false,0,true);
			downArrow.tabEnabled = false;
			downArrow.setFocusEnabled(false);
			downArrow.addEventListener(MouseEvent.MOUSE_DOWN,onScrollArrowDown,false,0,true);
			thumb.tabEnabled = false;
			thumb.setFocusEnabled(false);
			thumb.addEventListener(MouseEvent.MOUSE_DOWN,onScrollThumbDown,false,0,true);
			trackSkin.addEventListener(MouseEvent.MOUSE_DOWN,onScrollTrackDown,false,0,true);
			repaint();
		}
				public override function set enabled(value:Boolean):void {
			super.enabled = value;
			upArrow.enabled = downArrow.enabled = thumb.enabled = enabled;
			thumb.visible = enabled;
		}
		public override function get tabEnabled():Boolean {
			return false;
		}
		public override function get tabChildren():Boolean {
			return false;
		}
		public override function getFocusEnabled():Boolean {
			return false;
		}
				public override function set x(value:Number):void {
			super.x = _1 == VERTICAL ? value : value + _height;
		}
		public override function get x():Number {
			return _1 == VERTICAL ? super.x : super.x - _height;
		}
				public override function set width(value:Number):void {
			if (_1 == VERTICAL) {
				if (_width == value){
					return;
				}
				_width = value;
			} else {
				if (_height == value){
					return;
				}
				super.x = super.x + (value - _height);
				_height = value;
			}
			repaint();
		}
		public override function get width():Number {
			return _1 == VERTICAL ? _width : _height;
		}
		public override function set height(value:Number):void {
			if (_1 == VERTICAL) {
				if (_height == value){
					return;
				}
				_height = value;
			} else {
				if (_width == value){
					return;
				}
				_width = value;
			}
			repaint();
		}
		public override function get height():Number {
			return _1 == VERTICAL ? _height : _width;
		}
		public override function setSize(width:Number, height:Number):void {
						if (_1 == VERTICAL) {
				if (_width == width && _height == height){
					return;
				}
				_width = width;
				_height = height;
			} else {
				if (_width == height && _height == width){
					return;
				}
				_width = height;
				_height = width;
			}
			repaint();
		}
		
		public function setOrientation(orientation:String):void {
			setDirection(orientation);
		}
		
		public function getOrientation():String {
			return getDirection();
		}
		
		public function setDirection(direction:String):void {
			if (_1 == direction) {
				return;
			}
			_1 = direction;
			if (direction == VERTICAL) {
				rotation = 0;
				super.x = super.x - _height;
			} else if (direction == HORIZONTAL) {
				rotation = 90;
				super.x = super.x + _height;
			}
		}
		
		public function getDirection():String {
			return _1;
		}
		
		public function getLineScrollSize():Number {
			return _5;
		}
		
		public function setLineScrollSize(lineSize:Number):void {
			_5 = lineSize;
		}
		
		public function getPageScrollSize():Number {
			return _6;
		}
		
		public function setPageScrollSize(pageSize:Number):void {
						if(_6 == pageSize){
				return;
			}
			_6 = pageSize;
			adjustSrollThumbSize();
			adjustScrollThumbPosition();
		}
		
		public function setScrollPosition(position:Number):void {
						position = Math.max(_2, Math.min(position, _3));
			if (_4 != position) {
				_4 = position;
				adjustScrollThumbPosition();
				dispatchEvent(new Event(Event.SCROLL, true));
			}
		}
		
		public function getScrollPosition():Number {
			return _4;
		}
		
		public function getMinScrollPosition():Number {
			return _2;
		}
		
		public function setMinScrollPosition(position:Number):void {
			if(_2 == position){
				return;
			}
			_2 = position;
			if (_3 < position) {
				_3 = position;
			}
			if (_4 < position){
				_4 = position;
			}
			adjustSrollThumbSize();
			adjustScrollThumbPosition();
		}
		
		public function getMaxScrollPosition():Number {
			return _3;
		}
		
		public function setMaxScrollPosition(position:Number):void {
			if (position < _2) {
				return;
			}
			if(_3 == position){
				return;
			}
			_3 = position;
			if(_4 > position){
				_4 = position;
			}
			adjustSrollThumbSize();
			adjustScrollThumbPosition();
		}
		
		
		[Event(name = "scroll",type = "flash.events.Event")]
		
		
		
				private function adjustSrollThumbSize():void {
			var _11:Number = _6/(_3-_2+_6);
			var _12:Number = (downArrow.y - upArrow.y - upArrow.height) * _11;
			_12 = int(_12);
			_12 = Math.max(upArrow.height,_12);
			thumb.height = _12;
		}
				private function adjustScrollThumbPosition():void {
			var _11:Number = upArrow.y + upArrow.height;
			var _12:Number = (downArrow.y - _11 - thumb.height)*(_4-_2)/(_3-_2);
			_12 = Math.round(_12);
			thumb.y = _1 == VERTICAL ? _11 + _12 : downArrow.y - _12 - thumb.height;
		}
		private function scrollIt(inc:String, mode:Number):void {
			var _11:Number = inc == "Line"?getLineScrollSize():getPageScrollSize();
			setScrollPosition(_4 + mode*_11);
		}
		private function scrollInterval(inc:String, mode:int):void {
						clearInterval(_7);
			if (_4 == _2 && mode < 0) {
				return;
			}
			if (_4 == _3 && mode > 0) {
				return;
			}
			if (inc == "Line") {
				scrollIt(inc, mode);
			} else {
				if(mouseY < thumb.y){
					if(mode == (_1 == VERTICAL ? -1 : 1)){
						scrollIt(inc, mode);
					}
				}else if(mouseY > thumb.y + thumb.height){
					if(mode == (_1 == VERTICAL ? 1 : -1)){
						scrollIt(inc, mode);
					}
				}
			}
			_7 = setInterval(scrollInterval,repeatInterval,inc,mode);
		}
		protected function onScrollArrowDown(evt:MouseEvent):void {
			_8 = "Line";
			clearInterval(_7);
			if(evt.currentTarget == upArrow){
				_9 = _1 == VERTICAL ?  -1 : 1;
				scrollIt(_8, _9);
				_7 = setInterval(scrollInterval,repeatDelay,_8,_9);
				upArrow.addEventListener(MouseEvent.ROLL_OUT,onScrollArrowOut,false,0,true);
				upArrow.addEventListener(MouseEvent.ROLL_OVER,onScrollArrowOver,false,0,true);
				downArrow.mouseEnabled = false;
			}else{
				_9 = _1 == VERTICAL ?  1 : -1;
				scrollIt(_8, _9);
				_7 = setInterval(scrollInterval,repeatDelay,_8,_9);
				downArrow.addEventListener(MouseEvent.ROLL_OUT,onScrollArrowOut,false,0,true);
				downArrow.addEventListener(MouseEvent.ROLL_OVER,onScrollArrowOver,false,0,true);
				upArrow.mouseEnabled = false;
			}
			thumb.mouseEnabled = false;
			stage.addEventListener(MouseEvent.MOUSE_UP,onScrollArrowUp,false,0,true);
		}
		protected function onScrollArrowOut(evt:MouseEvent):void{
			clearInterval(_7);
		}
		protected function onScrollArrowOver(evt:MouseEvent):void{
			scrollInterval(_8, _9);
		}
		protected function onScrollArrowUp(evt:MouseEvent):void{
			clearInterval(_7);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onScrollArrowUp);
			upArrow.removeEventListener(MouseEvent.ROLL_OUT,onScrollArrowOut);
			upArrow.removeEventListener(MouseEvent.ROLL_OVER,onScrollArrowOver);
			upArrow.mouseEnabled = true;
			downArrow.removeEventListener(MouseEvent.ROLL_OUT,onScrollArrowOut);
			downArrow.removeEventListener(MouseEvent.ROLL_OVER,onScrollArrowOver);
			downArrow.mouseEnabled = true;
			thumb.mouseEnabled = true;
		}
		protected function onScrollTrackDown(evt:MouseEvent):void {
			upArrow.mouseEnabled = downArrow.mouseEnabled = false;
			thumb.mouseEnabled = false;
			_8 = "Page";
			_9 = _1 == VERTICAL ? (mouseY > thumb.y ? 1:-1) : (mouseY > thumb.y+thumb.height ? -1:1);
			scrollIt(_8, _9);
			clearInterval(_7);
			_7 = setInterval(scrollInterval,repeatDelay,_8,_9);
			trackSkin.addEventListener(MouseEvent.ROLL_OUT,onScrollTrackOut,false,0,true);
			trackSkin.addEventListener(MouseEvent.ROLL_OVER,onScrollTrackOver,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_UP,onScrollTrackUp,false,0,true);
		}
		protected function onScrollTrackOut(evt:MouseEvent):void{
			clearInterval(_7);
		}
		protected function onScrollTrackOver(evt:MouseEvent):void{
			scrollInterval(_8, _9);
		}
		protected function onScrollTrackUp(evt:MouseEvent):void {
			clearInterval(_7);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onScrollTrackUp);
			trackSkin.removeEventListener(MouseEvent.ROLL_OUT,onScrollTrackOut);
			trackSkin.removeEventListener(MouseEvent.ROLL_OVER,onScrollTrackOver);
			upArrow.mouseEnabled = downArrow.mouseEnabled = true;
			thumb.mouseEnabled = true;
		}
		protected function onScrollThumbDown(evt:MouseEvent):void {
			
			_10 = evt.localY;
			thumb.mouseEnabled = false;
						stage.addEventListener(MouseEvent.MOUSE_MOVE,onScrollThumbMove,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_UP,onScrollThumbUp,false,0,true);
			stage.mouseChildren = false;
		}
		protected function onScrollThumbUp(evt:MouseEvent):void {
						thumb.mouseEnabled = true;
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, onScrollThumbMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onScrollThumbUp);
			stage.mouseChildren = true;
						
			_10 = undefined;
		}
		protected function onScrollThumbMove(evt:MouseEvent):void {
			var _11:Number = mouseY - _10;
			var _12:Number = upArrow.y + upArrow.height;
			_11 = Math.max(_12,Math.min(downArrow.y-thumb.height,_11));
			_11 = Math.round(_11);
			if (_11 == thumb.y) {
				return;
			}
			thumb.y = _11;
			var _13:Number = downArrow.y-thumb.height-_12;
			var _14:Number = _1 == VERTICAL ? (thumb.y-_12)/_13 : (downArrow.y-thumb.y-thumb.height)/_13;
			var _15:Number = _2 + (_3 - _2)*_14;
			if (_4 != _15) {
				_4 = _15;
				dispatchEvent(new Event(Event.SCROLL));
			}
			evt.updateAfterEvent();
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			if(trackSkin.width != _width){
				trackSkin.width = _width;
				upArrow.width = downArrow.width = thumb.width = _width;
			}
			if(trackSkin.height != _height) {
				trackSkin.height = _height;
				downArrow.y = _height - upArrow.y - downArrow.height;
			}
			adjustSrollThumbSize();
			adjustScrollThumbPosition();
		}
	}
}

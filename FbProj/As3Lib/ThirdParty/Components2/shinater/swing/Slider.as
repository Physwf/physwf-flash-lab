package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class Slider extends Component {
		
		public static const VERTICAL:String = "vertical";
		
		public static const HORIZONTAL:String = "horizontal";
		private var _1:String = HORIZONTAL;
		private var _2:Number = 0;
		private var _3:Number = 10;
		private var _4:Number = 0;
		private var _5:Number = 1;
		private var _6:Boolean = false;
		private var _7:Boolean = false;
		private var _8:Boolean = true;
		private var _9:Number = 0;
		private var _10:Boolean = true;
		private var _11:Number;
		private var _12:Number;
		
		private var _13:Number;
		
		public var thumb:Button;
		
		public var trackSkin:Sprite;
				
		public var tickSkin:Sprite;
				
		public var repeatInterval:Number = 50;
		private var _14:uint;
		private var _15:int;
		
		public function Slider(min:Number = 0,max:Number = 10) {
			super();
			_2 = min;
			_3 = max;
		}
		protected override function init():void {
			if (rotation == -90) {
				_1 = VERTICAL;
				_11 = super.height;
				_12 = super.width;
			}else{
				_11 = super.width;
				_12 = super.height;
			}
			scaleX = scaleY = 1;
			super.init();
			if(tickSkin != null){
				removeChild(tickSkin);
			}
			_9 = thumb.getRect(thumb).x < 0 ? 0 : thumb.width;
			thumb.tabEnabled = false;
			thumb.setFocusEnabled(false);
			thumb.addEventListener(MouseEvent.MOUSE_DOWN,onThumbDown,false,0,true);
									trackSkin.addEventListener(MouseEvent.MOUSE_DOWN,onTrackDown,false,0,true);
			addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
			repaint();
		}
		public override function set enabled(value:Boolean):void {
			super.enabled = value;
			thumb.enabled = enabled;
		}
		public override function set y(value:Number):void {
			super.y = _1 == HORIZONTAL ? value : value + _11;
		}
		public override function get y():Number {
			return _1 == HORIZONTAL ? super.y : super.y - _11;
		}
		public override function set height(value:Number):void {
			if (_1 == HORIZONTAL) {
				return;
			}
			if (_11 == value){
				return
			}
			_11 = value;
			repaint();
		}
		public override function get height():Number {
			return _1 == HORIZONTAL ? super.height : _11;
		}
		public override function set width(value:Number):void {
			if (_1 == VERTICAL) {
				return;
			}
			if (_11 == value){
				return;
			}
			_11 = value;
			repaint();
		}
		public override function get width():Number {
			return _1 == HORIZONTAL ? _11 : super.height;
		}
		public override function setSize(width:Number, height:Number):void {
			if (_1 == HORIZONTAL) {
				if(_11 == width){
					return;
				}
				_11 = width;
			} else {
				if(_11 == height){
					return;
				}
				_11 = height;
			}
			repaint();
		}
		public override function get tabChildren():Boolean {
			return false;
		}
		public override function drawFocus(focused:Boolean):void {
			thumb.drawFocus(focused);
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
			if (direction == HORIZONTAL) {
				rotation = 0;
				super.y = super.y - _11;
			} else {
				rotation = -90;
				super.y = super.y + _11;
			}
		}
		
		public function getDirection():String {
			return _1;
		}
		
		public function setMinimum(minimum:Number):void {
			_2 = minimum;
			if (_3 < minimum) {
				_3 = minimum;
			}
			if (_4 < minimum){
				_4 = minimum;
			}
			repaint();
		}
		
		public function getMinimum():Number {
			return _2;
		}
		
		public function setMaximum(maximum:Number):void {
			if (maximum < _2) {
				return;
			}
			_3 = maximum;
			if(_4 > maximum){
				_4 = getValidValue(maximum);
			}
			repaint();
		}
		
		public function getMaximum():Number {
			return _3;
		}
		
		public function setValue(value:Number):void {
			value = getValidValue(value);
			if (_4 == value) {
				return;
			}
			_4 = value;
			adjustThumbPosition();
		}
		
		public function getValue():Number {
			return _4;
		}
		private function getValidValue(value:Number):Number{
			var _16:Number = _2;
			var _17:Number = _3;
			if (_5 > 0 && _8) {
				_17 = _2 + _5 * int((_3-_2)/_5);
				value = _2 + _5 * Math.round((value-_2)/_5);
			}
			value = Math.max(_16, Math.min(value, _17));
			return value;
		}
		
		public function setInverted(inverted:Boolean):void {
			_6 = inverted;
			repaint();
		}
		
		public function getInverted():Boolean {
			return _6;
		}
		
		public function setTickInterval(value:Number):void {
			_5 = value;
			if(_8){
				_4 = getValidValue(_4);
			}
			repaint();
		}
		
		public function getTickInterval():Number {
			return _5;
		}
		
		public function setPaintTicks(paint:Boolean):void {
			_7 = paint;
			repaint();
		}
		
		public function getPaintTicks():Boolean {
			return _7;
		}
		
		public function setSnapToTicks(snapToTicks:Boolean):void {
			_8 = snapToTicks;
			if(snapToTicks){
				_4 = getValidValue(_4);
				adjustThumbPosition();
			}
		}
		
		public function getSnapToTicks():Boolean {
			return _8;
		}
		
		public function setLiveDragging(liveDragging:Boolean):void{
			_10 = liveDragging;
		}
		
		public function getLiveDragging():Boolean{
			return _10;
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		
		
		
		private function adjustThumbPosition():void {
			var _16:Number = trackSkin.width;
			_16 -= _9;
			var _17:Number = _16 * (_4 - _2)/(_3 - _2);
			thumb.x = Math.round(_6 ? _16 - _17 : _17);
		}
		private function next(mode:int):void{
			var _16:Number = getValidValue(_4 + _5*mode);
			if(_16 != _4){
				_4 = _16;
				adjustThumbPosition();
				dispatchEvent(new Event(Event.CHANGE,false));
			}
		}
		private function sliderInterval(mode:int):void{
			clearInterval(_14);
			if (_4 == _2 && mode < 0) {
				return;
			}
			if (_4 == _3 && mode > 0) {
				return;
			}
			var _16:Number = trackSkin.width;
			var _17:Number = _9;
			_16 -= _17;
			var _18:Number = this.mouseX;
			var _19:Number = _18 - _17/2;
			var _20:Number = _3 - _2;
			var _21:Number = _2 + (_6 ? _16 - _19 : _19)/_16 * _20;
			_21 = getValidValue(_21);
			if(_21 != _4 && (_18 < thumb.x || _18 > thumb.x + thumb.width)){
				if(mode == (_21 < _4 ? -1 : 1)){
					next(mode);
				}
			}
			_14 = setInterval(sliderInterval,repeatInterval,mode);
		}
		protected function onTrackDown(evt:MouseEvent):void {
			var _16:Number = trackSkin.width;
			var _17:Number = _9;
			_16 -= _17;
			var _18:Number = mouseX - _17/2;
			var _19:Number = _3 - _2;
			var _20:Number = _2 + (_6 ? _16 - _18 : _18)/_16 * _19;
			_15 = _20 < _4 ? -1 : 1;
			thumb.mouseEnabled = false;
			_20 = getValidValue(_20);
			if(_4 != _20){
				_4 = _20;
				adjustThumbPosition();
				dispatchEvent(new Event(Event.CHANGE,false));
			}
			if(_5 > 0 && _8){
				_14 = setInterval(sliderInterval,repeatInterval,_15);
				trackSkin.addEventListener(MouseEvent.ROLL_OUT,onTrackOut,false,0,true);
				trackSkin.addEventListener(MouseEvent.ROLL_OVER,onTrackOver,false,0,true);
			}
			stage.addEventListener(MouseEvent.MOUSE_UP,onTrackUp,false,0,true);
		}
		protected function onTrackOut(evt:MouseEvent):void{
			clearInterval(_14);
		}
		protected function onTrackOver(evt:MouseEvent):void{
			sliderInterval(_15);
		}
		protected function onTrackUp(evt:MouseEvent):void {
			clearInterval(_14);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onTrackUp);
			trackSkin.removeEventListener(MouseEvent.ROLL_OUT,onTrackOut);
			trackSkin.removeEventListener(MouseEvent.ROLL_OVER,onTrackOver);
			thumb.mouseEnabled = true;
		}
		protected function onThumbDown(evt:MouseEvent):void {
			_13 = evt.localX;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onThumbMove,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_UP,onThumbUp,false,0,true);
			thumb.mouseEnabled = false;
			stage.mouseChildren = false;
		}
		protected function onThumbUp(evt:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onThumbMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onThumbUp);
			thumb.mouseEnabled = true;
			stage.mouseChildren = true;
						_13 = undefined;
			if(!_10){
				dispatchEvent(new Event(Event.CHANGE,false));
			}
		}
		protected function onThumbMove(evt:MouseEvent):void {
			var _16:Number = mouseX - _13;
			var _17:Number = trackSkin.width;
			_17 -= _9;
			_16 = Math.max(0,Math.min(_17,_16));
			var _18:Number = _3 - _2;
			var _19:Number = _2 + (_6 ? _17 - _16 : _16)/_17 * _18;
			_19 = getValidValue(_19);
			if(_4 != _19){
				_4 = _19;
				adjustThumbPosition();
				if(_10){
					dispatchEvent(new Event(Event.CHANGE,false));
				}
			}
		}
		protected function onKeyDown(evt:KeyboardEvent):void {
			var _16:int;
			if (_1 == HORIZONTAL){
				if(evt.keyCode == Keyboard.LEFT){
					_16 = -1;
				}else if(evt.keyCode == Keyboard.RIGHT){
					_16 = 1;
				}else{
					return;
				}
			}else{
				if(evt.keyCode == Keyboard.DOWN){
					_16 = -1;
				}else if(evt.keyCode == Keyboard.UP){
					_16 = 1;
				}else{
					return;
				}
			}
			if(_6){
				_16 *= -1;
			}
			next(_16);
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _16:Number = _11;
			trackSkin.width = _16;
			adjustThumbPosition();
			if (tickSkin == null) {
				return;
			}
			if (_5 <= 0 || ! _7) {
				if (tickSkin.parent == this) {
					for (var _17:int = numChildren - 1; _17 >= 0; _17--) {
						if (getChildAt(_17).name.indexOf("tick") == 0) {
							removeChildAt(_17);
						}
					}
				}
				return;
			}
			_16 -= _9;
			var _18:Number = (_9-tickSkin.width)/2;
			if(tickSkin.parent != this){
				addChildAt(tickSkin,1)
			}
			tickSkin.x = Math.round(_6 ? _16 + _18 : _18);
			var _19:Class = tickSkin["constructor"] as Class;
			var _20:DisplayObject = tickSkin;
			for (var _21:Number = _5,_22:uint = 1; _21 <= _3; _21+=_5,_22++) {
				var _23:Number = _16 * (_21 - _2)/(_3 - _2);
				_23 = Math.round((_6 ? _16-_23 : _23) + _18);
				if (_20 != null) {
					_20 = getChildByName("tick" + _22);
				}
				if (_20 != null) {
					_20.x = _23;
				} else {
					var _24:DisplayObject = new _19();
					_24.name = "tick" + _22;
					_24.x = _23;
					_24.y = tickSkin.y;
					addChildAt(_24,_22+1);
				}
			}
			if (_20 != null) {
				for (_17 = numChildren - 1,_22 = getChildIndex(_20) + 1; _17 >= _22; _17--) {
					if (getChildAt(_17).name.indexOf("tick") == 0) {
						removeChildAt(_17);
					}
				}
			}
		}
	}
}

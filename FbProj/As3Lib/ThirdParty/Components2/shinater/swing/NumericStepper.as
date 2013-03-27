package shinater.swing{
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.FocusEvent;
	import flash.ui.Keyboard;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import shinater.swing.managers.FocusManager;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class NumericStepper extends Component {
		
		public var textField:TextInput;
		
		public var upArrow:Button;
		
		public var downArrow:Button;
		
		public var repeatDelay:Number = 500;
		
		public var repeatInterval:Number = 50;
		private var _1:Number = 0;
		private var _2:Number = 10;
		private var _3:Number = 0;
		private var _4:int = 0;
		private var _5:Number = 1;
		private var _6:uint;
		private var _7:Boolean = true;
		protected var _width:Number;
		protected var _height:Number;
		
		public function NumericStepper() {
			super();
		}
		protected override function init():void{
			_width = super.width;
			_height = super.height;
			scaleX = scaleY = 1;
			super.init();
			upArrow.tabEnabled = false;
			upArrow.setFocusEnabled(false);
			upArrow.addEventListener(MouseEvent.MOUSE_DOWN,onSteperArrowDown,false,0,true);
			downArrow.tabEnabled = false;
			downArrow.setFocusEnabled(false);
			downArrow.addEventListener(MouseEvent.MOUSE_DOWN,onSteperArrowDown,false,0,true);
			textField.setRestrict("0-9\\-.");
			textField.setMaxChars(2);
			textField.setText("0");
			textField.tabEnabled = false;
			textField.setFocusEnabled(false);
			textField.addEventListener(Event.CHANGE,onTextChanged,false,0,true);
			textField.addEventListener(FocusEvent.FOCUS_OUT,onFocusOut,false,0,true);
			addEventListener(FocusEvent.FOCUS_IN,onFocusIn,false,0,true);
			addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
			repaint();
		}
		public override function set enabled(value:Boolean):void {
			super.enabled = value;
			upArrow.enabled = downArrow.enabled = enabled;
			textField.enabled = enabled;
		}
		public override function set width(value:Number):void {
			if(_width == value){
				return;
			}
			repaint();
		}
		public override function set height(value:Number):void {
			if(_height == value){
				return;
			}
			_height = value;
			repaint();
		}
		public override function setSize(width:Number,height:Number):void {
			if(_width == width && _height == height){
				return;
			}
			_width = width;
			_height = height;
			repaint();
		}
		public override function setTextFormat(textFormat:TextFormat):void {
			textField.setTextFormat(textFormat);
		}
		public override function getTextFormat():TextFormat {
			return textField.getTextFormat();
		}
		public override function setDisabledTextFormat(textFormat:TextFormat):void {
			textField.setDisabledTextFormat(textFormat);
		}
		public override function getDisabledTextFormat():TextFormat {
			return textField.getDisabledTextFormat();
		}
		public override function setFocus():void {
			if (getFocusEnabled()) {
				FocusManager.setFocus(textField.textField);
			}
		}
		public override function drawFocus(focused:Boolean):void {
			textField.drawFocus(focused);
		}
		
		public function setMaximum(maximum:Number):void {
			if (maximum < _1) {
				return;
			}
			_2 = maximum;
			if(_3 > maximum){
				_3 = getValidValue(maximum);
				textField.setText(_3 == 0 && _4 == 0 ? "0" : _3.toFixed(_4));
			}
			var _8:int = Math.max(int(_1).toString().length,int(maximum).toString().length);
			if(_4 > 0){
				_8 += _4 + 1;
			}
			textField.setMaxChars(_8);
		}
		
		public function getMaximum():Number {
			return _2;
		}
		
		public function setMinimum(minimum:Number):void {
			_1 = minimum;
			if (_2 < minimum) {
				_2 = minimum;
			}
			if (_3 < minimum) {
				_3 = getValidValue(minimum);
				textField.setText(_3 == 0 && _4 == 0 ? "0" : _3.toFixed(_4));
			}
			var _8:int = Math.max(int(minimum).toString().length,int(_2).toString().length);
			if(_4 > 0){
				_8 += _4 + 1;
			}
			textField.setMaxChars(_8);
		}
		
		public function getMinimum():Number {
			return _1;
		}
		
		public function getNextValue():Number {
			return getValidValue(_3+_5);
		}
		
		public function getPreviousValue():Number {
			return getValidValue(_3-_5);
		}
		
		public function setStepSize(stepSize:Number):void {
			_5 = stepSize;
			var _8:String = stepSize.toString();
			var _9:int = _8.indexOf(".");
			var _10:int = Math.max(int(_1).toString().length,int(_2).toString().length);
			if(_9 == -1){
				_4 = 0;
				_3 = getValidValue(_3);
				textField.setMaxChars(_10);
				textField.setText(_3.toString());
			}else{
				_4 = _8.length - _9 - 1;
				_3 = getValidValue(_3);
				textField.setMaxChars(_10 + _4 + 1);
				textField.setText(_3.toFixed(_4));
			}
		}
		
		public function getStepSize():Number {
			return _5;
		}
		
		public function setValue(value:Number):void {
			value = getValidValue(value);
			if(_3 == value){
				return;
			}
			_3 = value;
			textField.setText(_3 == 0 && _4 == 0 ? "0" : _3.toFixed(_4));
		}
		
		public function getValue():Number {
			return _3
		}
		private function getValidValue(value:Number):Number{
			var _8:Number = Number(_1.toFixed(_4));
			var _9:Number;
			if(_7){
				_9 = Number((_1 + (_5 * Math.floor((_2-_1)/_5))).toFixed(_4));
				if(_8 < _1){
					_8 = Math.min(_8 + _5, _9);
				}
				value = Number((_1 + (_5 * Math.round((value-_1)/_5))).toFixed(_4));
			}else{
				_9 = Number(_2.toFixed(_4));
				if(_8 < _1){
					_8 = Math.min(_8 + 1/Math.pow(10,_4), _9);
				}
				value = Number(value.toFixed(_4));
			}
			value = Math.max(_8, Math.min(value, _9));
			return value;
		}
		
		public function setEditable(editable:Boolean):void {
			textField.setEditable(editable);
			textField.textField.selectable = editable;
		}
		
		public function getEditable():Boolean {
			return textField.getEditable();
		}
		
		public function setSnapToStep(snapToStep:Boolean):void{
			_7 = snapToStep;
			if(snapToStep){
				_3 = getValidValue(_3);
				textField.setText(_3 == 0 && _4 == 0 ? "0" : _3.toFixed(_4));
			}
		}
		
		public function getSnapToStep():Boolean{
			return _7;
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		private function next(mode:int):void{
			var _8:Number = getValidValue(_3 + mode*_5);
			if(_8 != _3){
				_3 = _8;
				var _9:String = _3 == 0 && _4 == 0 ? "0" : _3.toFixed(_4);
				textField.setText(_9);
				textField.setSelection(_9.length,_9.length);
				dispatchEvent(new Event(Event.CHANGE,false));
			}
		}
		private function steperInterval(mode:int):void{
			clearInterval(_6);
			if (_3 == _1 && mode < 0) {
				return;
			}
			if (_3 == _2 && mode > 0) {
				return;
			}
			next(mode);
			_6 = setInterval(steperInterval,repeatInterval,mode);
		}
		protected function onSteperArrowDown(evt:MouseEvent):void {
			clearInterval(_6);
			if(evt.currentTarget == upArrow){
				next(1);
				_6 = setInterval(steperInterval,repeatDelay,1);
				upArrow.addEventListener(MouseEvent.ROLL_OUT,onSteperArrowOut,false,0,true);
				upArrow.addEventListener(MouseEvent.ROLL_OVER,onSteperArrowOver,false,0,true);
			}else{
				next(-1);
				_6 = setInterval(steperInterval,repeatDelay,-1);
				downArrow.addEventListener(MouseEvent.ROLL_OUT,onSteperArrowOut,false,0,true);
				downArrow.addEventListener(MouseEvent.ROLL_OVER,onSteperArrowOver,false,0,true);
			}
			stage.addEventListener(MouseEvent.MOUSE_UP,onSteperArrowUp,false,0,true);
		}
		protected function onSteperArrowOut(evt:MouseEvent):void{
			clearInterval(_6);
		}
		protected function onSteperArrowOver(evt:MouseEvent):void{
			steperInterval(evt.currentTarget == upArrow ? 1 : -1);
		}
		protected function onSteperArrowUp(evt:MouseEvent):void{
			clearInterval(_6);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onSteperArrowUp);
			upArrow.removeEventListener(MouseEvent.ROLL_OUT,onSteperArrowOut);
			upArrow.removeEventListener(MouseEvent.ROLL_OVER,onSteperArrowOver);
			downArrow.removeEventListener(MouseEvent.ROLL_OUT,onSteperArrowOut);
			downArrow.removeEventListener(MouseEvent.ROLL_OVER,onSteperArrowOver);
		}
		protected function onTextChanged(evt:Event):void {
			var _8:String = textField.getText();
			var _9:int = _8.indexOf("-",1);
			if(_9 != -1){
				textField.setText(_8.charAt(0) + _8.substr(1).replace(/-/g, ""));
			}
			_9 = _8.indexOf(".");
			if(_9 != -1){
				var _10:int = _8.indexOf(".",_9+1);
				if(_10 != -1){
					textField.setText(_8.substr(0,_9+1) + _8.substr(_10).replace(/\\./g, ""));
				}
			}
			evt.stopPropagation();
		}
		protected function onFocusIn(evt:FocusEvent):void{
			if(stage.focus != textField.textField){
				stage.focus = textField.textField;
			}
		}
		protected function onFocusOut(evt:FocusEvent):void {
			var _8:String = textField.getText();
			var _9:Number = parseFloat(_8);
			var _10:Boolean = false;
			if(!isNaN(_9)){
				_9 = getValidValue(_9);
				if(_9 != _3){
					_3 = _9;
					_10 = true;
				}
			}
			_8 = _3 == 0 && _4 == 0 ? "0" : _3.toFixed(_4);
			if(textField.getText() != _8){
				textField.setText(_8);
			}
			if(_10){
				dispatchEvent(new Event(Event.CHANGE,false));
			}
		}
		protected function onKeyDown(evt:KeyboardEvent):void{
			var _8:Number;
			switch(evt.keyCode){
				case Keyboard.UP:
					_8 = getNextValue();
					break;
				case Keyboard.DOWN:
					_8 = getPreviousValue();
					break;
				case Keyboard.HOME:
					_8 = getValidValue(_1);
					break;
				case Keyboard.END:
					_8 = getValidValue(_2);
					break;
				case Keyboard.ENTER:
					var _9:String = textField.getText();
					onFocusOut(null);
					if(textField.getText() != _9){
						textField.setSelection(textField.getLength(),textField.getLength());
					}
				default:
					return;
			}
			if(_8 != _3){
				_3 = _8;
				textField.setText(_3 == 0 && _4 == 0 ? "0" : _3.toFixed(_4));
				dispatchEvent(new Event(Event.CHANGE,false));
			}
		}
		public override function repaint():void{
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			textField.repaint();
			if (textField.width != _width){
				textField.width = _width;
				upArrow.x = downArrow.x = _width - upArrow.y - upArrow.width;
			}
			textField.textField.width =  downArrow.x - textField.textField.x;
			if (textField.height != _height) {
				textField.height = _height;
				upArrow.height = downArrow.height = (_height - upArrow.y * 2)/2;
				downArrow.y = _height/2;
			}
		}
	}
}

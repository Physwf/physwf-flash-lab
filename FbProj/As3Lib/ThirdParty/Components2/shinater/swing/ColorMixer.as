package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.display.GradientType;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Mouse;
	import flash.ui.Keyboard;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.geom.Transform;
	import flash.geom.ColorTransform;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import shinater.swing.managers.StyleManager;

	
	public dynamic class ColorMixer extends Container {
		
		public var redValueField:NumericStepper;
		
		public var greenValueField:NumericStepper;
		
		public var blueValueField:NumericStepper;
		
		public var hueValueField:NumericStepper;
		
		public var saturationValueField:NumericStepper;
		
		public var brightnessValueField:NumericStepper;
		
		public var alphaValueField:NumericStepper;
		
		public var hexValueField:TextInput;
		
		public var colorSelectionBox:Sprite;
		
		public var colorMarkerSkin:Sprite;
		
		public var tintSlider:Slider;
		
		public var previewSwatch:Sprite;
		
		public var skin:Sprite;
		
		private var _1:DisplayObject;
		
		private var _2:uint = 0;
		private var _3:int = 100;
		private var _4:uint;
		private var _5:int = 0;
		private var _6:int = 0;
		private var _7:int = 0;
		private var _8:int = 0;
		private var _9:int = 0;
		private var _10:int = 0;
		private var _11:Boolean = false;
		
		public function ColorMixer() {
			super();
		}
		protected override function init():void {
			super.init();
			redValueField.setMaximum(255);
			redValueField.repeatInterval = 20;
			redValueField.textField.setRestrict("0-9");
			redValueField.textField.setMaxChars(3);
			greenValueField.setMaximum(255);
			greenValueField.repeatInterval = 20;
			greenValueField.textField.setRestrict("0-9");
			greenValueField.textField.setMaxChars(3);
			blueValueField.setMaximum(255);
			blueValueField.repeatInterval = 20;
			blueValueField.textField.setRestrict("0-9");
			blueValueField.textField.setMaxChars(3);
			redValueField.addEventListener(Event.CHANGE,onRGBChanged,false,0,true);
			greenValueField.addEventListener(Event.CHANGE,onRGBChanged,false,0,true);
			blueValueField.addEventListener(Event.CHANGE,onRGBChanged,false,0,true);
			redValueField.addEventListener(MouseEvent.MOUSE_DOWN,onNumericStepperDown,false,1,true);
			greenValueField.addEventListener(MouseEvent.MOUSE_DOWN,onNumericStepperDown,false,1,true);
			blueValueField.addEventListener(MouseEvent.MOUSE_DOWN,onNumericStepperDown,false,1,true);
			hueValueField.setMaximum(360);
			hueValueField.repeatInterval = 20;
			hueValueField.textField.setRestrict("0-9");
			hueValueField.textField.setMaxChars(3);
			saturationValueField.setMaximum(100);
			saturationValueField.repeatInterval = 20;
			saturationValueField.textField.setRestrict("0-9");
			saturationValueField.textField.setMaxChars(3);
			brightnessValueField.setMaximum(100);
			brightnessValueField.repeatInterval = 20;
			brightnessValueField.textField.setRestrict("0-9");
			brightnessValueField.textField.setMaxChars(3);
			hueValueField.addEventListener(Event.CHANGE,onHSBChanged,false,0,true);
			saturationValueField.addEventListener(Event.CHANGE,onHSBChanged,false,0,true);
			brightnessValueField.addEventListener(Event.CHANGE,onHSBChanged,false,0,true);
			hueValueField.addEventListener(MouseEvent.MOUSE_DOWN,onNumericStepperDown,false,1,true);
			saturationValueField.addEventListener(MouseEvent.MOUSE_DOWN,onNumericStepperDown,false,1,true);
			brightnessValueField.addEventListener(MouseEvent.MOUSE_DOWN,onNumericStepperDown,false,1,true);
			alphaValueField.setMaximum(100);
			alphaValueField.repeatInterval = 20;
			alphaValueField.textField.setRestrict("0-9%");
			alphaValueField.textField.setMaxChars(4);
			alphaValueField.textField.setText("100%");
			alphaValueField.textField.setSelection(3,3);
			alphaValueField.upArrow.addEventListener(MouseEvent.MOUSE_DOWN,onAlphaStepperDown,false,1,true);
			alphaValueField.upArrow.addEventListener(MouseEvent.MOUSE_UP,clearAlphaSteperInterval,false,1,true);
			alphaValueField.upArrow.addEventListener(MouseEvent.ROLL_OUT,clearAlphaSteperInterval,false,1,true);
			alphaValueField.downArrow.addEventListener(MouseEvent.MOUSE_DOWN,onAlphaStepperDown,false,1,true);
			alphaValueField.downArrow.addEventListener(MouseEvent.MOUSE_UP,clearAlphaSteperInterval,false,1,true);
			alphaValueField.downArrow.addEventListener(MouseEvent.ROLL_OUT,clearAlphaSteperInterval,false,1,true);
			alphaValueField.textField.addEventListener(Event.CHANGE,onAlphaFieldTextChanged,false,1,true);
			alphaValueField.textField.addEventListener(FocusEvent.FOCUS_OUT,onAlphaFieldFocusOut,false,1,true);
			alphaValueField.addEventListener(KeyboardEvent.KEY_DOWN,onAlphaFieldKeyDown,false,1,true);
			alphaValueField.addEventListener(Event.CHANGE,onAlphaChanged,false,0,true);
			alphaValueField.addEventListener(MouseEvent.MOUSE_DOWN,onNumericStepperDown,false,1,true);
			hexValueField.setRestrict("#A-Fa-f0-9");
			hexValueField.setMaxChars(7);
			hexValueField.addEventListener(Event.CHANGE,onHexValueChanged,false,0,true);
			hexValueField.addEventListener(KeyboardEvent.KEY_DOWN,onHexValueFieldKeyDown,false,0,true);
			hexValueField.addEventListener(FocusEvent.FOCUS_OUT,onHexValueFieldFocusOut,false,0,true);
			createRainbowColorBox();
			initTintSlider();
			initPreviewSwatch();
			setColor(0);
			repaint();
		}
		public override function set width(value:Number):void{
		}
		public override function set height(value:Number):void{
		}
		
		public function setColor(color:uint):void {
			_2 = color;
			_5 = (color & 0xFF0000) >> 16;
			_6 = (color & 0x00FF00) >> 8;
			_7 = color & 0x0000FF;
			redValueField.setValue(_5);
			greenValueField.setValue(_6);
			blueValueField.setValue(_7);
			var _12:Array = RGBtoHSB(_5,_6,_7);
			_8 = _12[0];
			_9 = _12[1];
			_10 = _12[2];
			hueValueField.setValue(_8);
			saturationValueField.setValue(_9);
			brightnessValueField.setValue(_10);
			hexValueField.setText("#" + getHexValue());
			adjustColorSelection();
		}
		
		public function getColor():uint{
			return _2;
		}
		
		public function getHexValue():String{
			var _12:String = _2.toString(16);
			return "00000".substr(0,6-_12.length) + _12.toUpperCase();
		}
		
		public function setAlpha(alpha:Number):void{
			_3 = int(alpha * 100);
			alphaValueField.setValue(_3);
			alphaValueField.textField.setText(_3 + "%");
			preview(_2,_3);
		}
		
		public function getAlpha():Number{
			return _3 / 100;
		}
		private function preview(color:uint, alpha:Number):void{
			var _12:Number = previewSwatch.width;
			var _13:Number = previewSwatch.height;
			var _14:Shape = Shape(previewSwatch.getChildByName("currentSwatch"));
			_13 /= 2;
			var _15:Graphics = _14.graphics;
			_15.clear();
			_15.beginFill(color,alpha/100);
			_15.drawRect(0,0,_12,_13);
			_15.endFill();
			if(!_11){
				var _16:Shape = Shape(previewSwatch.getChildByName("lastSwatch"));
				_15 = _16.graphics;
				_15.clear();
				_15.beginFill(color,alpha/100);
				_15.drawRect(0,0,_12,_13);
				_15.endFill();
			}
		}
		private function adjustColorSelection():void{
			var _12:Array = RGBtoHSL(_5,_6,_7);
			var _13:int = _12[0];
			var _14:int = _12[1];
			var _15:Number = _13/360*colorSelectionBox.scrollRect.width;
			var _16:Number = colorSelectionBox.scrollRect.height * (100-_14)/100;
			_15 = int(_15);
			_16 = int(_16);
			colorMarkerSkin.x = _15;
			colorMarkerSkin.y = _16;
			var _17:Array = HSLtoRGB(_13,_14,50);
			var _18:Transform = tintSlider.trackSkin.getChildByName("colorSwatch").transform;
			var _19:ColorTransform = _18.colorTransform;
			_19.color = _17[0] << 16 ^ _17[1] << 8 ^ _17[2];
			_18.colorTransform = _19;
			tintSlider.setValue(_12[2]);
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		protected function onRGBChanged(evt:Event):void {
			switch(evt.currentTarget){
				case redValueField:
					_5 = redValueField.getValue();
					break;
				case greenValueField:
					_6 = greenValueField.getValue();
					break;
				case blueValueField:
					_7 = blueValueField.getValue();
			}
			_2 = _5 << 16 ^ _6 << 8 ^ _7;
			var _12:Array = RGBtoHSB(_5,_6,_7);
			_8 = _12[0];
			_9 = _12[1];
			_10 = _12[2];
			hueValueField.setValue(_8);
			saturationValueField.setValue(_9);
			brightnessValueField.setValue(_10);
			hexValueField.setText("#" + getHexValue());
			adjustColorSelection();
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected function onHSBChanged(evt:Event):void {
			switch(evt.currentTarget){
				case hueValueField:
					_8 = hueValueField.getValue();
					break;
				case saturationValueField:
					_9 = saturationValueField.getValue();
					break;
				case brightnessValueField:
					_10 = brightnessValueField.getValue();
			}
			var _12:Array = HSBtoRGB(_8,_9,_10);
			_5 = _12[0];
			_6 = _12[1];
			_7 = _12[2];
			_2 = _5 << 16 ^ _6 << 8 ^ _7;
			redValueField.setValue(_5);
			greenValueField.setValue(_6);
			blueValueField.setValue(_7);
			hexValueField.setText("#" + getHexValue());
			adjustColorSelection();
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		private function nextAlphaValue(mode:int):void{
			var _12:Number = Math.max(0,Math.min(_3 + mode*1,100));
			if(_12 != _3){
				_3 = _12;
				var _13:String = _12 + "%";
				alphaValueField.setValue(_12);
				onAlphaChanged(null);
			}
		}
		private function alphaSteperInterval(mode:int):void{
			clearInterval(_4);
			if (_3 == 0 && mode < 0) {
				return;
			}
			if (_3 == 100 && mode > 0) {
				return;
			}
			nextAlphaValue(mode);
			_4 = setInterval(alphaSteperInterval,alphaValueField.repeatInterval,mode);
		}
		private function clearAlphaSteperInterval(evt:MouseEvent):void {
			clearInterval(_4);
		}
		protected function onAlphaStepperDown(evt:MouseEvent):void{
			var _12:int = evt.currentTarget == alphaValueField.upArrow ? 1 : -1;
			nextAlphaValue(_12);
			clearInterval(_4);
			_4 = setInterval(alphaSteperInterval,alphaValueField.repeatDelay,_12);
			evt.stopImmediatePropagation();
		}
		protected function onAlphaFieldFocusOut(evt:FocusEvent):void{
			if(evt != null){
				evt.stopImmediatePropagation();
			}
			var _12:String = alphaValueField.textField.getText();
			var _13:Number = parseFloat(_12);
			if(!isNaN(_13)){
				_13 = Math.max(0,Math.min(100,_13));
				if(_13 != _3){
					alphaValueField.setValue(_13);
					onAlphaChanged(null);
					return;
				}
			}
			_12 = _3 + "%";
			if(alphaValueField.textField.getText() != _12){
				alphaValueField.textField.setText(_12);
				alphaValueField.textField.setSelection(_12.length-1,_12.length-1);
			}
		}
		protected function onAlphaFieldKeyDown(evt:KeyboardEvent):void{
			evt.stopImmediatePropagation();
			var _12:Number;
			switch(evt.keyCode){
				case Keyboard.UP:
					_12 = alphaValueField.getNextValue();
					break;
				case Keyboard.DOWN:
					_12 = alphaValueField.getPreviousValue();
					break;
				case Keyboard.HOME:
					_12 = 0;
					break;
				case Keyboard.END:
					_12 = 100;
					break;
				case Keyboard.ENTER:
					onAlphaFieldFocusOut(null);
				default:
					return;
			}
			if(_12 != _3){
				alphaValueField.setValue(_12);
				onAlphaChanged(null);
			}
		}
		protected function onAlphaFieldTextChanged(evt:Event):void{
			var _12:String = alphaValueField.textField.getText();
			var _13:int = _12.indexOf("%");
			if(_13 != -1 && _13 != _12.length-1){
				alphaValueField.textField.setText(_12.substring(0,_13+1));
			}
			evt.stopImmediatePropagation();
		}
		protected function onAlphaChanged(evt:Event):void{
			_3 = alphaValueField.getValue();
			var _12:String = _3 + "%";
			alphaValueField.textField.setText(_12);
			alphaValueField.textField.setSelection(_12.length-1,_12.length-1);
			preview(_2,_3);
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected function onNumericStepperDown(evt:MouseEvent):void{
			_11 = true;
			stage.addEventListener(MouseEvent.MOUSE_UP,onNumericStepperUp,false,0,true);
		}
		protected function onNumericStepperUp(evt:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onNumericStepperUp);
			_11 = false;
			preview(_2,_3);
		}
		protected function onHexValueChanged(evt:Event):void{
			var _12:String = hexValueField.getText();
			var _13:int = _12.indexOf("#",1);
			if(_13 != -1){
				hexValueField.setText(_12.charAt(0) + _12.substr(1).replace(/#/g, ""));
			}
			evt.stopPropagation();
		}
		protected function onHexValueFieldKeyDown(evt:KeyboardEvent):void{
			if(evt.keyCode == Keyboard.ENTER){
				var _12:String = hexValueField.getText();
				onHexValueFieldFocusOut(null);
				if(hexValueField.getText() != _12){
					hexValueField.setSelection(hexValueField.getLength(),hexValueField.getLength());
				}
			}
		}
		protected function onHexValueFieldFocusOut(evt:FocusEvent):void{
			var _12:String = hexValueField.getText();
			if(_12.indexOf("#") != -1){
				_12 = _12.replace(/#/g, "");
			}
			if(_12.length > 6){
				_12 = _12.substr(0,6);
			}
			var _13:int = parseInt(_12,16);
			if(isNaN(_13)){
				_13 = 0;
			}
			if(_13 != _2){
				setColor(_13);
				dispatchEvent(new Event(Event.CHANGE,false));
			}else{
				_12 = "#" + getHexValue();
				if(hexValueField.getText() != _12){
					hexValueField.setText(_12);
				}
			}
		}
				private function createRainbowColorBox():void{
			var _12:Number = colorSelectionBox.width;
			var _13:Number = colorSelectionBox.height;
			var _14:Array = [0xFF0000, 0xFFFF00, 0x00FF00, 0x00FFFF, 0x0000FF, 0xFF00FF, 0xFF0000];
			var _15:Array = [1, 1, 1, 1, 1, 1, 1];
			var _16:Array = [0x00, 0x2A, 0x55, 0x7F, 0xAA, 0xD4, 0xFF];
			var _17:Matrix = new Matrix();
			_17.createGradientBox(_12,_13,0,0,0);
			var _18:Graphics = colorSelectionBox.graphics;
			_18.beginGradientFill(GradientType.LINEAR, _14, _15, _16, _17);
			_18.drawRect(0,0,_12,_13);
			_18.endFill();
			_14 = [0x000000, 0x404040];
			_15 = [0, 1];
			_16 = [0x00, 0xFF];
			_17.createGradientBox(_12,_13,Math.PI/2,0,0);
			_18.beginGradientFill(GradientType.LINEAR, _14, _15, _16, _17);
			_18.drawRect(0,0,_12,_13);
			_18.endFill();
			colorSelectionBox.addEventListener(MouseEvent.MOUSE_DOWN,onColorSelectionBoxDown,false,0,true);
			colorSelectionBox.tabEnabled = false;
			colorSelectionBox.addChild(colorMarkerSkin);
			colorSelectionBox.scrollRect = new Rectangle(0,0,_12,_13);
		}
		private function initTintSlider():void{
			tintSlider.height = colorSelectionBox.height;
			var _12:Sprite = tintSlider.trackSkin;
			var _13:Number = _12.width;
			var _14:Number = _12.height;
			var _15:Shape = new Shape();
			_15.name = "colorSwatch";
			var _16:Graphics = _15.graphics;
			_16.beginFill(0x808080);
			_16.drawRect(0,0,_13,_14);
			_16.endFill();
			_12.addChild(_15);
			var _17:Array = [0xFFFFFF, 0xFFFFFF, 0x000000, 0x000000];
			var _18:Array = [1, 0, 0, 1];
			var _19:Array = [0x00, 0x7F, 0x80, 0xFF];
			var _20:Matrix = new Matrix();
			_20.createGradientBox(_13,_14,Math.PI,0,0);
			var _21:Shape = new Shape();
			_16 = _21.graphics;
			_16.beginGradientFill(GradientType.LINEAR, _17, _18, _19, _20);
			_16.drawRect(0,0,_13,_14);
			_16.endFill();
			_12.addChild(_21);
			tintSlider.mouseChildren = false;
			tintSlider.tabEnabled = false;
			tintSlider.setFocusEnabled(false);
			tintSlider.setMaximum(100);
			tintSlider.addEventListener(MouseEvent.MOUSE_DOWN,onTintSliderDown,false,0,true);
			tintSlider.addEventListener(Event.CHANGE,onTintChanged,false,0,true);
		}
		private function initPreviewSwatch():void{
			var _12:Number = previewSwatch.width;
			var _13:Number = previewSwatch.height;
			var _14:Shape = new Shape();
			_13 /= 2;
			var _15:Graphics = _14.graphics;
			_15.beginFill(0);
			_15.drawRect(0,0,_12,_13);
			_15.endFill();
			_14.name = "currentSwatch";
			previewSwatch.addChild(_14);
			var _16:Shape = new Shape();
			_15 = _16.graphics;
			_15.beginFill(0);
			_15.drawRect(0,0,_12,_13);
			_15.endFill();
			_16.y = _13;
			_16.name = "lastSwatch";
			previewSwatch.addChild(_16);
		}
		protected function onColorSelectionBoxDown(evt:MouseEvent):void{
			Mouse.hide();
			var _12:DisplayObject = _1;
			if(_12 == null){
				var _13:Class = colorMarkerSkin["constructor"] as Class;
				_12 = _1 = new _13() as DisplayObject;
				_12.blendMode = BlendMode.INVERT;
				colorSelectionBox.addChild(_12);
			}
			_11 = true;
			onColorMarkerMove(evt);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onColorMarkerMove,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_UP,onColorSelectionBoxUp,false,0,true);
			stage.mouseChildren = false;
		}
		protected function onColorSelectionBoxUp(evt:MouseEvent):void{
			var _12:DisplayObject = _1;
			colorMarkerSkin.x = _12.x;
			colorMarkerSkin.y = _12.y;
			colorSelectionBox.removeChild(_12);
			_1 = null;
			_11 = false;
			preview(_2,_3);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onColorMarkerMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onColorSelectionBoxUp);
			stage.mouseChildren = true;
			Mouse.show();
		}
		protected function onColorMarkerMove(evt:MouseEvent):void {
			var _12:Number = colorSelectionBox.scrollRect.width;
			var _13:Number = colorSelectionBox.scrollRect.height;
			var _14:Number = Math.max(0, Math.min(colorSelectionBox.mouseX, _12));
			var _15:Number = Math.max(0, Math.min(colorSelectionBox.mouseY, _13));
			var _16:DisplayObject = _1;
			_16.x = int(_14);
			_16.y = int(_15);
			var _17:int = Math.round(_14/_12 * 360);
			var _18:int = Math.round((_13-_15) / _13 * 100);
			var _19:int = tintSlider.getValue();
			var _20:Array = HSLtoRGB(_17,_18,_19);
			_5 = _20[0];
			_6 = _20[1];
			_7 = _20[2];
			redValueField.setValue(_5);
			greenValueField.setValue(_6);
			blueValueField.setValue(_7);
			_2 = _5 << 16 ^ _6 << 8 ^ _7;
			hexValueField.setText("#" + getHexValue());
			_20 = HSLtoRGB(_17,_18,50);
			var _21:Transform = tintSlider.trackSkin.getChildByName("colorSwatch").transform;
			var _22:ColorTransform = _21.colorTransform;
			_22.color = _20[0] << 16 ^ _20[1] << 8 ^ _20[2];
			_21.colorTransform = _22;
			var _23:Array = RGBtoHSB(_5,_6,_7);
			_8 = _23[0];
			_9 = _23[1];
			_10 = _23[2];
			hueValueField.setValue(_8);
			saturationValueField.setValue(_9);
			brightnessValueField.setValue(_10);
			preview(_2,_3);
			dispatchEvent(new Event(Event.CHANGE,false));
			evt.updateAfterEvent();
		}
		protected function onTintChanged(evt:Event):void {
			var _12:int = _8;
			var _13:Number = colorSelectionBox.scrollRect.height;
			var _14:Number = colorMarkerSkin.y;
			var _15:int = Math.round((_13-_14) / _13 * 100);
			var _16:int = tintSlider.getValue();
			var _17:Array = HSLtoRGB(_12,_15,_16);
			_5 = _17[0];
			_6 = _17[1];
			_7 = _17[2];
			redValueField.setValue(_5);
			greenValueField.setValue(_6);
			blueValueField.setValue(_7);
			_2 = _5 << 16 ^ _6 << 8 ^ _7;
			hexValueField.setText("#" + getHexValue());
			var _18:Array = RGBtoHSB(_5,_6,_7);
			_8 = _18[0];
			_9 = _18[1];
			_10 = _18[2];
			hueValueField.setValue(_8);
			saturationValueField.setValue(_9);
			brightnessValueField.setValue(_10);
			preview(_2,_3);
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected function onTintSliderDown(evt:MouseEvent):void {
			Mouse.hide();
			_11 = true;
			onTintSlider(evt);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onTintSlider,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_UP,onTintSliderUp,false,0,true);
			stage.mouseChildren = false;
		}
		protected function onTintSliderUp(evt:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onTintSlider);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onTintSliderUp);
			stage.mouseChildren = true;
			Mouse.show();
			_11 = false;
			preview(_2,_3);
		}
		protected function onTintSlider(evt:MouseEvent):void {
			tintSlider.trackSkin.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,false));
			evt.updateAfterEvent();
		}
		public override function repaint():void {
						if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			redValueField.repaint();
			greenValueField.repaint();
			blueValueField.repaint();
			hueValueField.repaint();
			saturationValueField.repaint();
			brightnessValueField.repaint();
			hexValueField.repaint();
			alphaValueField.repaint();
			alphaValueField.textField.textField.width = alphaValueField.width;
			adjustColorSelection();
			preview(_2,_3);
		}
						private static function RGBtoHSL(red:Number, green:Number, blue:Number):Array {
			red /= 255;
			green /= 255;
			blue /= 255;
			var _12:Number = Math.max(red, green, blue);
			var _13:Number = Math.min(red, green, blue);
			var _14:Number = (_12+_13)/2;
			var _15:Number,_16:Number;
			var _17:Number = _12 - _13;
			if (_17 == 0) {
				_15 = 0;
				_16 = 0;
			} else {
				if (_14 < 0.5) {
					_16 = _17/(_12+_13);
				} else {
					_16 = _17/(2-_12-_13);
				}
				if (red == _12) {
					_15 = (green-blue)/_17;
				} else if (green == _12) {
					_15 = 2+(blue-red)/_17;
				} else {
					_15 = 4+(red-green)/_17;
				}
				_15 *= 60;
				if (_15 < 0) {
					_15 += 360;
				}
				_15 = Math.round(_15);
				_16 = Math.round(_16 * 100);
			}
			_14 = Math.round(_14 * 100);
			return [_15, _16, _14];
		}
		private static function HSLtoRGB(hue:Number, saturation:Number, lighteness:Number):Array {
			saturation /= 100;
			lighteness /= 100;
			if (saturation == 0) {
				return [Math.round(lighteness * 255), Math.round(lighteness * 255), Math.round(lighteness * 255)];
			}
			var p, _12:Number;
			if (lighteness < 0.5) {
				_12 = lighteness * (1+saturation);
			} else {
				_12 = lighteness + saturation - lighteness*saturation;
			}
			p = 2*lighteness - _12;
			var _13:Number = hue/360;
			var _14:Array = [];
			for (var _15:int = 0; _15 < 3; _15++) {
				var _16:Number = 0;
				switch (_15) {
					case 0 :
						_16 = _13 + 1/3;
						break;
					case 1 :
						_16 = _13;
						break;
					case 2 :
						_16 = _13 - 1/3;
				}
				if (_16 < 0) {
					_16 = _16 + 1;
				} else if (_16 > 1) {
					_16 = _16 - 1;
				}
				if (_16 < 1/6) {
					_14[_15] = p + (_12-p) * 6 * _16;
				} else if (_16 < 1/2) {
					_14[_15] = _12;
				} else if (_16 < 2/3) {
					_14[_15] = p + (_12-p) * 6 * (2/3-_16);
				} else {
					_14[_15] = p;
				}
				_14[_15] = Math.round(_14[_15] * 255);
			}
			return _14;
		}
		private static function RGBtoHSB(red:Number, green:Number, blue:Number):Array {
			red /= 255;
			green /= 255;
			blue /= 255;
			var _12:Number = Math.max(red, green, blue);
			var _13:Number = Math.min(red, green, blue);
			var _14:Number = _12;
			var _15:Number,_16:Number;
			var _17:Number = _12 - _13;
			if (_17 == 0) {  
				_15 = 0;  
				_16 = 0;
			} else {
				_16 = _17/_12;
				if (red == _12) {
					_15 = (green-blue)/_17;
				} else if (green == _12) {
					_15 = 2+(blue-red)/_17;
				} else {
					_15 = 4+(red-green)/_17;
				}
				_15 *= 60;
				if (_15 < 0) {
					_15 += 360;
				}
				_15 = Math.round(_15);
				_16 = Math.round(_16 * 100);
			}
			_14 = Math.round(_14 * 100);
			return [_15, _16, _14];
		}
		private static function HSBtoRGB(hue:Number, saturation:Number, brightness:Number):Array {
			saturation /= 100;
			brightness /= 100;
			var _12:Number,_13:Number,_14:Number;
			if (saturation == 0) {
				_12 = _13 = _14 = brightness;
			} else {
				var _15:int = int(hue/60);
	    		var _16:Number = hue/60 - _15;
	    		var _17:Number = brightness * (1 - saturation);
	    		var _18:Number = brightness * (1 - saturation * _16);
	    		var _19:Number = brightness * (1 - (saturation * (1 - _16)));
				switch (_15) {
					case 0 :
						_12 = brightness; _13 = _19; _14 = _17;
						break;
					case 1 :
						_12 = _18; _13 = brightness; _14 = _17;
						break;
					case 2 :
						_12 = _17; _13 = brightness; _14 = _19;
						break;
					case 3 :
						_12 = _17; _13 = _18; _14 = brightness;
						break;
					case 4 :
						_12 = _19; _13 = _17; _14 = brightness;
						break;
					case 5 :
						_12 = brightness; _13 = _17; _14 = _18;
				}
			}
			return [Math.round(_12 * 255), Math.round(_13 * 255), Math.round(_14 * 255)];
		}
	}
}

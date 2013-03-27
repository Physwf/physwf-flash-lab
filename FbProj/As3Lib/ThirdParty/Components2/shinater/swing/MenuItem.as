package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class MenuItem extends Button {
		protected var _enabled:Boolean = true;
		protected var _mnemonic:String;
		protected var _accelerator:String;
		protected var _arrowPaddingRight:Number;
		protected var _textPaddingRight:Number;
		
		public var acceleratorTextField:TextField;
		
		public var arrowSkin:Sprite;
				
		public function MenuItem(label:String = null) {
			super();
			if(label != null){
				setLabel(label);
			}
		}
		protected override function init():void {
			super.init();
			_textPaddingY = textField.y;
			if(arrowSkin != null){
				_arrowPaddingRight = width - arrowSkin.x - arrowSkin.width;
			}
			_textPaddingRight = width - acceleratorTextField.x - acceleratorTextField.width;
			removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			addEventListener(MouseEvent.MOUSE_UP,onMouseUp,false,1,true);
			addEventListener(MouseEvent.CLICK,onClick,false,0,true);
								}
		public override function set enabled(value:Boolean):void {
			if (_enabled == value) {
				return;
			}
			_enabled = value;
			setMouseState(stage != null && this.hitTestPoint(stage.mouseX,stage.mouseY,true) ? "over":"up");
		}
		public override function get enabled():Boolean {
			return _enabled;
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
		
		public override function setLabel(label:String):void {
			var _1:int = label.indexOf("&");
			if (_1 != -1 && _1 < label.length - 1) {
				var _2:String = label.charAt(_1 + 1);
				if (_2 != "&") {
					_mnemonic = _2;
				}
				label = label.replace("&","");
			}
			super.setLabel(label);
		}
		
		public function setAccelerator(keyStroke:String,modifiers:int=0) {
			if (keyStroke != null && modifiers != 0) {
				if (modifiers == Keyboard.CONTROL + Keyboard.SHIFT) {
					keyStroke = "Ctrl+Shift+" + keyStroke;
				} else {
					if (modifiers == Keyboard.SHIFT) {
						keyStroke = "Shift+" + keyStroke;
					}
					if (modifiers == Keyboard.CONTROL) {
						keyStroke = "Ctrl+" + keyStroke;
					}
				}
			}
			if (_accelerator == null && keyStroke != null) {
				addEventListener(Event.ADDED_TO_STAGE,onAddedToStage,false,0,true);
				addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage,false,0,true);
				if (stage != null) {
					onAddedToStage(null);
				}
			}
			_accelerator = keyStroke;
		}
		
		public function getAccelerator():String {
			return _accelerator;
		}
		
		public function setMnemonic(mnemonic:String):void {
			_mnemonic = mnemonic;
		}
		
		public function getMnemonic():String {
			return _mnemonic;
		}
		protected function onAddedToStage(evt:Event):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
		}
		protected function onRemovedFromStage(evt:Event):void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		protected override function onRollOver(evt:MouseEvent):void {
						if (_mouseState != "up"){
				return;
			}
			setMouseState(evt.buttonDown&&_enabled ? "down" : "over");
		}
		protected override function onMouseDown(evt:MouseEvent):void {
			if (! _enabled) {
				evt.stopImmediatePropagation();
				return;
			}
			setMouseState("down");
		}
		protected override function onMouseUp(evt:MouseEvent):void {
			if (! _enabled) {
				evt.stopImmediatePropagation();
				return;
			}
			setMouseState("over");
		}
		protected function onClick(evt:MouseEvent):void {
			if(! _enabled){
				evt.stopImmediatePropagation();
			}
		}
		protected override function onKeyDown(evt:KeyboardEvent):void {
			if (! _enabled) {
				return;
			}
			var _1:String = _accelerator;
			if (_1 == null) {
				return;
			}
			_1 = _1.toUpperCase();
			var _2:String = _1;
			var _3:int = _1.lastIndexOf("+");
			if (_3 != -1) {
				_2 = _1.substr(_3 + 1);
				if ((_1.indexOf("CTRL+") != -1 || _1.indexOf("CONTROL+") != -1) && ! evt.ctrlKey) {
					return;
				}
				if (_1.indexOf("SHIFT+") != -1 && ! evt.shiftKey) {
					return;
				}
			}
			if (_2 != String.fromCharCode(evt.charCode).toUpperCase()) {
				return;
			}
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,false,0,0,null,evt.ctrlKey,evt.altKey,evt.shiftKey,false));
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,false,0,0,null,evt.ctrlKey,evt.altKey,evt.shiftKey,false));
			dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,evt.ctrlKey,evt.altKey,evt.shiftKey,false));
		}
		public override function setMouseState(state:String):void {
			_mouseState = state;
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"setMouseState",state)){
				return;
			}
			var _1:Boolean = arrowSkin != null && arrowSkin.visible;
			switch(state){
				case "up":
					gotoAndStop(_enabled ? 1:4);
					break;
				case "over":
					gotoAndStop(_enabled ? 2:5);
					break;
				case "down":
					if(!_enabled){
						return;
					}
					gotoAndStop(3);
			}
			var _2:DisplayObject = !_enabled ? getDisabledIcon() : null;
			if(_2 == null){
				_2 = getIcon();
			}
			if(this.icon != _2){
				if(this.icon != null){
					removeChild(this.icon);
				}
				if(_2 != null){
					addChild(_2);
				}
				this.icon = _2;
			}
			repaint();
			if(arrowSkin != null){
				arrowSkin.visible = _1;
			}
		}
		public override function repaint():void {
						if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _1:TextFormat = _enabled ? getTextFormat() : getDisabledTextFormat();
			var _2:String = getLabel();
			if(_2 != null){
				if (_mnemonic != null) {
					var _3:String = _2.toUpperCase();
					var _4:String = _mnemonic.toUpperCase()
					var _5:int = _3.indexOf(_4);
					if(_5 != -1){
						if(_3.indexOf("(" + _4 + ")") == -1){
							_2 = _2.substring(0,_5) + "<U>" + _2.charAt(_5) + "</U>" + _2.substr(_5 + 1);
						}
					}else{
						var _6:String = "(" + _mnemonic + ")";
						if (_2.substr(_2.length - 3) == "...") {
							_2 = _2.substr(0,_2.length - 3) + _6 + "...";
						} else {
							_2 += _6;
						}
					}
				}
				textField.htmlText = _2;
				if(_1 != null){
					textField.setTextFormat(_1);
				}
				textField.autoSize = TextFieldAutoSize.LEFT;
			}
			acceleratorTextField.htmlText = _accelerator || "";
			if(_1 != null){
				acceleratorTextField.setTextFormat(_1);
			}
			acceleratorTextField.autoSize = TextFieldAutoSize.LEFT;
			if (icon != null) {
				icon.x = _textPaddingX;
				icon.y = Math.ceil((_height - icon.height) / 2);
				textField.x = icon.x + icon.width + _textPaddingX;
			} else {
				textField.x = _textPaddingX;
			}
			var _7:Number = _width;
			var _8:Number = _height;
			if (getAutoSize()) {
				acceleratorTextField.x = textField.x + textField.width + _textPaddingRight;
				_7 = int(acceleratorTextField.x + acceleratorTextField.width + _textPaddingRight);
			}else{
				acceleratorTextField.x = _7 - _textPaddingRight - acceleratorTextField.width;
			}
			skin.width = _7;
			skin.height = _8;
			if(arrowSkin != null){
				arrowSkin.x = _7 - _arrowPaddingRight - arrowSkin.width;
			}
		}
	}
}

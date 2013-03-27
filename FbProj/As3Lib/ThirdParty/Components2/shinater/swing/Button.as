package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class Button extends Component {
		
		public static const LABELPLACEMENT_LEFT:String = "left";
		
		public static const LABELPLACEMENT_RIGHT:String = "right";
		
		public static const LABELPLACEMENT_TOP:String = "top";
		
		public static const LABELPLACEMENT_BOTTOM:String = "bottom";
		protected var _label:String = null;
		protected var _autoSize:Boolean = false;
		protected var _width:Number;
		protected var _height:Number;
		protected var _labelPlacement:String = LABELPLACEMENT_RIGHT;
		protected var _textPaddingX:Number = 5;
		protected var _textPaddingY:Number = 2;
		protected var _emphasizedPaddingX:Number = 0;
		protected var _emphasizedPaddingY:Number = 0;
		private var _1:DisplayObject;
		private var _2:Boolean = false;
		
		private var _3:DisplayObject;
		
		
		public var icon:DisplayObject;
		
		public var textField:TextField;
		
		public var skin:Sprite;
				
		public var emphasizedSkin:Sprite;
		
		public function Button(label:String = null) {
			super();
			if(label != null){
				setLabel(label);
			}
		}
		protected override function init():void {
			gotoAndStop(1);
			_width = super.width;
			_height = super.height;
						if (icon != null) {
				_textPaddingX = icon.x;
				_textPaddingY = icon.y;
				if (textField != null) {
					if (textField.height > icon.height) {
						_textPaddingY = textField.y;
					}
					_label = textField.text;
				}
			} else if (textField != null) {
				_textPaddingX = textField.x;
				_textPaddingY = textField.y;
				_label = textField.text;
			}
			if (scaleX != 1 || scaleY != 1) {
				scaleX = scaleY = 1;
				repaint();
			}
			super.init();
			buttonMode = true;
			useHandCursor = false;
			mouseChildren = false;
			tabChildren = false;
			if(emphasizedSkin != null){
				emphasizedSkin.visible = false;
			}
			addEventListener(MouseEvent.ROLL_OUT,onRollOut,false,0,true);
			addEventListener(MouseEvent.ROLL_OVER,onRollOver,false,0,true);
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown,false,0,true);
			addEventListener(MouseEvent.MOUSE_UP,onMouseUp,false,0,true);
			addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
			addEventListener(KeyboardEvent.KEY_UP,onKeyUp,false,0,true)
														}
				public override function set mouseEnabled(value:Boolean):void {
			if (super.mouseEnabled == value) {
				return;
			}
			super.mouseEnabled = value;
			mouseChildren = false;
			if(value){
				setMouseState(stage!=null && hitTestPoint(stage.mouseX,stage.mouseY,true) ? "over" : "up");
			}
		}
		public override function set enabled(value:Boolean):void {
			if (super.enabled == value) {
				return;
			}
			super.enabled = value;
			mouseEnabled = value;
			if(!value){
				setMouseState("disabled");
			}
		}
				public override function set width(value:Number):void {
			if(_width == value){
				return;
			}
			_width = value;
			repaint();
		}
		public override function get width():Number {
			return getAutoSize() ? super.width : _width;
		}
		public override function set height(value:Number):void {
			if(_height == value){
				return;
			}
			_height = value;
			repaint();
		}
		public override function get height():Number {
			return getAutoSize() ? super.height : _height;
		}
		public override function setSize(width:Number,height:Number):void {
			if(_width == width && _height == height){
				return;
			}
			_width = width;
			_height = height;
			repaint();
		}
		
		public function setIcon(icon:DisplayObject):void {
			if(_1 == icon){
				return;
			}
			_1 = icon;
			_2 = true;
			setMouseState(_mouseState);
		}
		
		public function getIcon():DisplayObject {
			if(_2){
				return _1;
			}
			return icon;
		}
		
		public function setDisabledIcon(icon:DisplayObject):void{
			if(_3 == icon){
				return;
			}
			_3 = icon;
			setMouseState(_mouseState);
		}
		
		public function getDisabledIcon():DisplayObject{
			return _3;
		}
		
		public function setLabel(label:String):void {
			if(_label == label){
				return;
			}
			_label = label;
			repaint();
		}
		
		public function getLabel():String {
			return _label;
		}
		
		public function setLabelPlacement(placement:String):void {
			_labelPlacement = placement;
			repaint();
		}
		
		public function getLabelPlacement():String {
			return _labelPlacement;
		}
		
		public function setAutoSize(auto:Boolean):void {
			if(_autoSize == auto){
				return;
			}
			_autoSize = auto;
			repaint();
		}
		
		public function getAutoSize():Boolean {
			return _autoSize;
		}
		
		
		
		
		
		
		public override function toString():String {
			return super.toString().replace("]", ":"+_label+"]");
		}
				protected var _mouseState:String = "up";
		private var _4:Boolean = false;
		protected function onRollOut(evt:MouseEvent):void {
						if (! mouseEnabled){
				return;
			}
			if(_mouseState == "down"){
				_4 = true;
				stage.addEventListener(MouseEvent.MOUSE_UP,onRelease,false,0,true);
			}
			setMouseState("up");
		}
		protected function onRollOver(evt:MouseEvent):void {
						if (_mouseState != "up"){
				return;
			}
			setMouseState(_4 ? "down" :"over");
		}
		protected function onMouseDown(evt:MouseEvent):void {
						setMouseState("down");
		}
		protected function onMouseUp(evt:MouseEvent):void {
						var _5:String = _mouseState;
			setMouseState("over");
			if(_5 == "down"){
							}
		}
		private function onRelease(evt:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onRelease);
			_4 = false;
		}
		protected function onKeyDown(evt:KeyboardEvent):void {
			if (evt.keyCode != Keyboard.SPACE){
				return;
			}
			if(_mouseState != "down"){
				setMouseState("down");
			}
		}
		protected function onKeyUp(evt:KeyboardEvent):void {
			if (evt.keyCode != Keyboard.SPACE){
				return;
			}
			setMouseState(hitTestPoint(stage.mouseX,stage.mouseY,true) ? "over":"up");
			dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,evt.ctrlKey,evt.altKey,evt.shiftKey,false));
		}
		
		
		public function setMouseState(state:String):void {
						if(! enabled && state != "disabled"){
				return;
			}
			_mouseState = state;
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"setMouseState",state)){
				return;
			}
			switch(state){
				case "up":
					gotoAndStop(1);
					break;
				case "over":
					gotoAndStop(2);
					break;
				case "down":
					gotoAndStop(3);
					break;
				case "disabled":
					gotoAndStop(4);
			}
			var _5:DisplayObject = !enabled ? getDisabledIcon() : null;
			if(_5 == null){
				_5 = getIcon();
			}
			if(this.icon != _5){
				if(this.icon != null){
					removeChild(this.icon);
				}
				if(_5 != null){
					addChild(_5);
				}
				this.icon = _5;
			}
			repaint();
			if(state != "up"){
				if(emphasizedSkin != null && emphasizedSkin.visible && emphasizedSkin.alpha != 0){
					emphasizedSkin.alpha = 0;
				}
			}
		}
				public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _5:Number = _width;
			var _6:Number = _height;
			if (textField != null) {
												var _7:String = getLabel();
				if(_7 != null){
					textField.htmlText = _7;
					var _8:TextFormat = enabled ? getTextFormat() : getDisabledTextFormat();
					if(_8 != null){
						textField.setTextFormat(_8);
					}
				}
				if(getAutoSize()){
					textField.autoSize = TextFieldAutoSize.LEFT;
					if(icon == null || _labelPlacement == LABELPLACEMENT_TOP || _labelPlacement == LABELPLACEMENT_BOTTOM){
						textField.x = _textPaddingX;
						_5 = textField.width + _textPaddingX * 2;
						if(icon == null){
							textField.y = _textPaddingY;
							_6 = textField.height + _textPaddingY * 2;
						}else{
							icon.x = Math.ceil((_5 - icon.width) / 2);
							if (_labelPlacement == LABELPLACEMENT_BOTTOM) {
								icon.y = _textPaddingY;
								textField.y = _textPaddingY*2 + icon.height;
							} else {
								textField.y = _textPaddingY;
								icon.y = _textPaddingY*2 + textField.height;
							}
							_6 = icon.height + textField.height + _textPaddingY * 3;
						}
					}else{
						if (_labelPlacement == LABELPLACEMENT_RIGHT) {
							icon.x = _textPaddingX;
							textField.x = _textPaddingX*2 + icon.width;
						} else {
							textField.x = _textPaddingX;
							icon.x = _textPaddingX*2 + textField.width;
						}
						_5 = icon.width + textField.width + _textPaddingX * 3;
						_6 = Math.max(icon.height,textField.height) + _textPaddingY * 2;
						icon.y = Math.ceil((_6 - icon.height) / 2);
						textField.y = Math.ceil((_6 - textField.height) / 2);
					}
				}else{
					var _9:Boolean = textField.defaultTextFormat.align != TextFormatAlign.CENTER;
					if(icon == null || _labelPlacement == LABELPLACEMENT_TOP || _labelPlacement == LABELPLACEMENT_BOTTOM){
						textField.autoSize = TextFieldAutoSize.NONE;
						var _10:Number = _5 - _textPaddingX * 2;
						if(textField.textWidth < _10 || _9){
							textField.width = _10;
							textField.x = _textPaddingX;
						}else{
							textField.width = _5;
							textField.x = 0;
						}
						if(icon == null){
							textField.y = Math.ceil((_6 - textField.height) / 2);
						}else{
							icon.x = Math.ceil((_5 - icon.width) / 2);
							var _11:Number = icon.height + _textPaddingY + textField.height;
							var _12:Number = Math.ceil((_6 - _11) / 2);
							if (_labelPlacement == LABELPLACEMENT_BOTTOM) {
								icon.y = _12;
								textField.y = _12 + icon.height + _textPaddingY;
							} else {
								textField.y = _12;
								icon.y = _12 + textField.height + _textPaddingY;
							}
						}
					}else{
						var _13:Number = _textPaddingX * 3 + icon.width;
						if(_5 <= _13){
							icon.x = Math.ceil((_5 - icon.width) / 2);
							textField.autoSize = TextFieldAutoSize.NONE;
							textField.width = 0;
						}else{
							textField.autoSize = TextFieldAutoSize.LEFT;
							_10 = _5 - _13;
							if (textField.width > _10 || _9) {
								textField.autoSize = TextFieldAutoSize.NONE;
								textField.width = _10;
								if (_labelPlacement == LABELPLACEMENT_RIGHT) {
									icon.x = _textPaddingX;
									textField.x = _textPaddingX*2 + icon.width;
								} else {
									textField.x = _textPaddingX;
									icon.x = _textPaddingX*2 + textField.width;
								}
							} else {
								var _14:Number = icon.width + _textPaddingX + textField.width;
								var _15:Number = Math.ceil((_5 - _14) / 2);
								if (_labelPlacement == LABELPLACEMENT_RIGHT) {
									icon.x = _15;
									textField.x = _15+ icon.width + _textPaddingX;
								} else {
									textField.x = _15;
									icon.x = _15 + textField.width + _textPaddingX;
								}
							}
						}
						icon.y = Math.ceil((_6 - icon.height) / 2);
						textField.y = Math.ceil((_6 - textField.height) / 2);
					}
				}
			} else if(icon != null) {
				icon.x = _labelPlacement == LABELPLACEMENT_LEFT ? _5 - icon.width - _textPaddingX : Math.ceil((_5 - icon.width) / 2);
				icon.y = Math.ceil((_6 - icon.height) / 2);
				
			}
			if (skin != null) {
				skin.width = _5;
				skin.height = _6;
			}
			if(emphasizedSkin != null){
				if(emphasizedSkin.alpha != 1){
					emphasizedSkin.alpha = 1;
				}
				emphasizedSkin.width = _5;
				emphasizedSkin.height = _6;
			}
			if(focusRectSkin != null){
				focusRectSkin.width = _5;
				focusRectSkin.height = _6;
			}
		}
	}
}

package shinater.swing{
	import flash.display.DisplayObject;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class RadioButton extends ToggleButton {
		protected var _iconPaddingX:Number = 0;
		protected var _iconPaddingY:Number = 0;
		private var _1:String;
				
		public function RadioButton(label:String = null) {
			super();
			if(label != null){
				setLabel(label);
			}
		}
		protected override function init():void {
			super.init();
			_iconPaddingX = icon.x;
			_iconPaddingY = icon.y;
			_textPaddingX = textField.x - icon.x - icon.width;
			_textPaddingY = textField.y;
			setAutoSize(true);
			setGroupName("radioGroup");
					}
		
		public function setGroupName(groupName:String):void {
			_1 = groupName;
		}
		
		public function getGroupName():String {
			return _1;
		}
		private function getGroup():Array {
			if(parent == null){
				return [this];
			}
			var _2:Array = [];
			for(var _3:int = 0,_4:uint = parent.numChildren; _3<_4; _3++){
				var _5:DisplayObject = parent.getChildAt(_3);
				if(_5 is RadioButton){
					var _6:RadioButton = RadioButton(_5);
					if(_6.getGroupName() == _1){
						_2.push(_6);
					}
				}
			}
			return _2;
		}
		private static function setSelection(button:RadioButton):void {
			var _2:Array = button.getGroup();
			for (var _3:int = 0, _4:uint = _2.length; _3<_4; _3++) {
				var _5:RadioButton = _2[_3];
				if(_5 != button && _5.getSelected()){
					_5.setSelected(false);
				}
			}
		}
		public override function setSelected(selected:Boolean):void {
			if (_selected == selected) {
				return;
			}
			_selected = selected;
			setMouseState(_mouseState);
			if(selected){
				setSelection(this);
			}
		}
		public override function get tabEnabled():Boolean {
			if(!super.tabEnabled){
				return false;
			}
			if(_selected){
				return true;
			}
			var _2:Array = getGroup();
			for(var _3:int = 0,_4:uint = _2.length; _3<_4; _3++){
				if(_2[_3].getSelected()){
					return false;
				}
			}
			return _2[0] == this;
		}
				protected override function onClick(evt:MouseEvent):void {
						if (_selected) {
				return;
			}
			_selected = true;
			setSelection(this);
		}
		protected override function onKeyDown(evt:KeyboardEvent):void {
			super.onKeyDown(evt);
			var _2:Array = getGroup();
			var _3:uint = _2.length;
			if(_3 == 1){
				return;
			}
			var _4:int = _2.indexOf(this);
			if(evt.keyCode == Keyboard.LEFT || evt.keyCode == Keyboard.UP){
				_4 = _4 == 0 ? _3 - 1 : _4 - 1; 
			}else if(evt.keyCode == Keyboard.RIGHT || evt.keyCode == Keyboard.DOWN){
				_4 = _4 == _3 - 1 ? 0 : _4 + 1;
			}else{
				return;
			}
			for(var _5:int = 0; _5 < _3; _5++){
				var _6:RadioButton = _2[_5];
				if(_5 == _4){
					if(!_6.getSelected()){
						_6.setSelected(true);
						_6.setFocus();
						_6.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,evt.ctrlKey,evt.altKey,evt.shiftKey,false));
					}
				}else if(_6.getSelected()){
					_6.setSelected(false);
				}
			}
		}
				public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _2:Number = _width;
			var _3:Number = _height;
						var _4:String = getLabel();
			if(_4 != null){
				textField.htmlText = _4;
				var _5:TextFormat = enabled ? getTextFormat() : getDisabledTextFormat();
				if(_5 != null){
					textField.setTextFormat(_5);
				}
			}
			textField.autoSize = TextFieldAutoSize.LEFT;
			var _6:String = getLabelPlacement();
			if(_6 == LABELPLACEMENT_TOP || _6 == LABELPLACEMENT_BOTTOM){
				if(_autoSize){
					textField.x = 0;
					icon.x = Math.ceil((textField.width - icon.width) / 2);
				}else{
					if(textField.width <= _2){
						textField.x = Math.ceil((_2 - textField.width) / 2);
					}else{
						textField.x = 0;
						textField.autoSize = TextFieldAutoSize.NONE;
						textField.width = _2;
					}
					icon.x = Math.ceil((_2 - icon.width) / 2);
				}
				if (_6 == LABELPLACEMENT_BOTTOM) {
					icon.y = _iconPaddingY;
					textField.y = _iconPaddingY + icon.height + _textPaddingY;
				} else {
					textField.y = _textPaddingY;
					icon.y = _textPaddingY*2 + textField.height;
				}
			}else{
				if(!_autoSize){
					var _7:Number = _2 - _iconPaddingX - icon.width - _textPaddingX;
					if(textField.width > _7){
						textField.autoSize = TextFieldAutoSize.NONE;
						textField.width = _7;
					}
					if(_6 == LABELPLACEMENT_LEFT){
						icon.x = Math.ceil(_2 - _iconPaddingX - icon.width);
						textField.x = icon.x - _textPaddingX - textField.width;
					}
				}else if(_6 == LABELPLACEMENT_LEFT){
					textField.x = _iconPaddingX;
					icon.x =  _iconPaddingX + textField.width + _textPaddingX;
				}
				if (_6 == LABELPLACEMENT_RIGHT) {
					icon.x = _iconPaddingX;
					textField.x = _iconPaddingX + icon.width + _textPaddingX;
				}
				icon.y = _iconPaddingY;
				textField.y = _textPaddingY;
			}
			if(focusRectSkin != null){
				focusRectSkin.x = icon.x;
				focusRectSkin.y = icon.y;
			}
		}
	}
}

package shinater.swing{
	import flash.display.DisplayObject;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class CheckBox extends ToggleButton {
		protected var _iconPaddingX:Number = 0;
		protected var _iconPaddingY:Number = 0;
		
		public function CheckBox(label:String = null) {
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
					}
				public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _1:Number = _width;
			var _2:Number = _height;
						var _3:String = getLabel();
			if(_3 != null){
				textField.htmlText = _3;
				var _4:TextFormat = enabled ? getTextFormat() : getDisabledTextFormat();
				if(_4 != null){
					textField.setTextFormat(_4);
				}
			}
			textField.autoSize = TextFieldAutoSize.LEFT;
			var _5:String = getLabelPlacement();
			if(_5 == LABELPLACEMENT_TOP || _5 == LABELPLACEMENT_BOTTOM){
				if(_autoSize){
					textField.x = 0;
					icon.x = Math.ceil((textField.width - icon.width) / 2);
				}else{
					if(textField.width <= _1){
						textField.x = Math.ceil((_1 - textField.width) / 2);
					}else{
						textField.x = 0;
						textField.autoSize = TextFieldAutoSize.NONE;
						textField.width = _1;
					}
					icon.x = Math.ceil((_1 - icon.width) / 2);
				}
				if (_5 == LABELPLACEMENT_BOTTOM) {
					icon.y = _iconPaddingY;
					textField.y = _iconPaddingY + icon.height + _textPaddingY;
				} else {
					textField.y = _textPaddingY;
					icon.y = _textPaddingY*2 + textField.height;
				}
			}else{
				if(!_autoSize){
					var _6:Number = _1 - _iconPaddingX - icon.width - _textPaddingX;
					if(textField.width > _6){
						textField.autoSize = TextFieldAutoSize.NONE;
						textField.width = _6;
					}
					if(_5 == LABELPLACEMENT_LEFT){
						icon.x = Math.ceil(_1 - _iconPaddingX - icon.width);
						textField.x = icon.x - _textPaddingX - textField.width;
					}
				}else if(_5 == LABELPLACEMENT_LEFT){
					textField.x = _iconPaddingX;
					icon.x =  _iconPaddingX + textField.width + _textPaddingX;
				}
				if (_5 == LABELPLACEMENT_RIGHT) {
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

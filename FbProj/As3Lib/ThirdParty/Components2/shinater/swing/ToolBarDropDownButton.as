package shinater.swing{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import shinater.swing.managers.PopUpManager;
	import shinater.swing.managers.StyleManager;
	
	
	public dynamic class ToolBarDropDownButton extends ToolBarButton {
		
		public var dropdown:Component;
		protected var _textPaddingRight:Number = 0;
		
		public function ToolBarDropDownButton(icon:DisplayObject = null, label:String = null) {
			super();
			if(icon != null){
				setIcon(icon);
			}
			if(label != null){
				setLabel(label);
			}
		}
		protected override function init():void{
			super.init();
			if(skin != null){
				if (textField != null) {
					_textPaddingRight = skin.width - textField.x - textField.width;
				}else if(icon != null){
					_textPaddingRight = skin.width - icon.x - icon.width;
				}
			}
			setDropDownComponent(dropdown);
			tabEnabled = false;
			setFocusEnabled(false);
		}
		
		public function setDropDownComponent(component:Component):void{
			if(dropdown != null){
				dropdown.removeEventListener("hide", onDropdownHide);
				if(dropdown.parent != null){
					dropdown.parent.removeChild(dropdown);
				}
			}
			dropdown = component;
			if(dropdown != null){
				dropdown.addEventListener("hide",onDropdownHide,false,0,true);
				dropdown.visible = false;
			}
		}
		
		public function getDropDownComponent():Component{
			return dropdown;
		}
		private function showPopup():void {
			dropdown.repaint();
			var _1:Boolean = (parent is ToolBar) && ToolBar(parent).getDirection() == ToolBar.VERTICAL;
			var _2:Point = _1 ? new Point(width,0) : new Point(0,height);
			_2 = localToGlobal(_2);
			if(_2.x + dropdown.width > stage.stageWidth){
				_2.x = Math.max(0,_2.x+(_1 ? -width : width)-dropdown.width);
			}
			if(_2.y + dropdown.height > stage.stageHeight){
				_2.y = Math.max(0,_2.y+(_1 ? height : -height)-dropdown.height);
			}
			_2 = globalToLocal(_2);
			PopUpManager.show(dropdown,this,_2.x,_2.y);
			mouseEnabled = false;
		}
		protected override function onMouseDown(evt:MouseEvent):void {
			if (! _enabled){
				evt.stopImmediatePropagation();
				return;
			}
			super.onMouseDown(evt);
			if(dropdown == null){
				return;
			}
			showPopup();
		}
		protected function onDropdownHide(evt:Event):void {
			mouseEnabled = true;
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _1:Number = _width;
			var _2:Number = _height;
			var _3:String = getLabel();
			if(_3 != null && _3 != "" && textField != null){
				textField.visible = true;
				textField.htmlText = _3;
				var _4:TextFormat = enabled ? getTextFormat() : getDisabledTextFormat();
				if(_4 != null){
					textField.setTextFormat(_4);
				}
				if(getAutoSize()){
					textField.autoSize = TextFieldAutoSize.LEFT;
					if(icon == null || _labelPlacement == LABELPLACEMENT_TOP || _labelPlacement == LABELPLACEMENT_BOTTOM){
						textField.x = _textPaddingX;
						_1 = textField.width + _textPaddingX + _textPaddingRight;
						if(icon == null){
							textField.y = _textPaddingY;
							_2 = textField.height + _textPaddingY * 2;
						}else{
							icon.x = _textPaddingX + Math.ceil((_1 - _textPaddingRight - _textPaddingX - icon.width) / 2);
							if (_labelPlacement == LABELPLACEMENT_BOTTOM) {
								icon.y = _textPaddingY;
								textField.y = _textPaddingY*2 + icon.height;
							} else {
								textField.y = _textPaddingY;
								icon.y = _textPaddingY*2 + textField.height;
							}
							_2 = icon.height + textField.height + _textPaddingY * 3;
						}
					}else{
						if (_labelPlacement == LABELPLACEMENT_RIGHT) {
							icon.x = _textPaddingX;
							textField.x = _textPaddingX*2 + icon.width;
						} else {
							textField.x = _textPaddingX;
							icon.x = _textPaddingX*2 + textField.width;
						}
						_1 = icon.width + textField.width + _textPaddingX * 2 + _textPaddingRight;
						_2 = Math.max(icon.height,textField.height) + _textPaddingY * 2;
						icon.y = Math.ceil((_2 - icon.height) / 2);
						textField.y = Math.ceil((_2 - textField.height) / 2);
					}
				}else{
					if(icon == null || _labelPlacement == LABELPLACEMENT_TOP || _labelPlacement == LABELPLACEMENT_BOTTOM){
						textField.autoSize = TextFieldAutoSize.NONE;
						var _5:Number = _1 - _textPaddingX - _textPaddingRight;
						textField.width = _5;
						textField.x = _textPaddingX;
						if(icon == null){
							textField.y = Math.ceil((_2 - textField.height) / 2);
						}else{
							icon.x = _textPaddingX + Math.ceil((_1 - _textPaddingRight - _textPaddingX - icon.width) / 2);
							var _6:Number = icon.height + _textPaddingY + textField.height;
							var _7:Number = Math.ceil((_2 - _6) / 2);
							if (_labelPlacement == LABELPLACEMENT_BOTTOM) {
								icon.y = _7;
								textField.y = _7 + icon.height + _textPaddingY;
							} else {
								textField.y = _7;
								icon.y = _7 + textField.height + _textPaddingY;
							}
						}
					}else{
						var _8:Number = _textPaddingX * 2 + icon.width + _textPaddingRight;
						if(_8 >= _1){
							icon.x = _textPaddingX + Math.ceil((_1 - _textPaddingRight - _textPaddingX - icon.width) / 2);
							textField.autoSize = TextFieldAutoSize.NONE;
							textField.width = 0;
						}else{
							textField.autoSize = TextFieldAutoSize.LEFT;
							_5 = _1 - _8;
							if (textField.width > _5) {
								textField.autoSize = TextFieldAutoSize.NONE;
								textField.width = _5;
								if (_labelPlacement == LABELPLACEMENT_RIGHT) {
									icon.x = _textPaddingX;
									textField.x = _textPaddingX*2 + icon.width;
								} else {
									textField.x = _textPaddingX;
									icon.x = _textPaddingX*2 + textField.width;
								}
							} else {
								var _9:Number = icon.width + _textPaddingX + textField.width;
								var _10:Number = _textPaddingX + Math.ceil((_1 - _textPaddingRight - _textPaddingX - _9) / 2);
								if (_labelPlacement == LABELPLACEMENT_RIGHT) {
									icon.x = _10;
									textField.x = _10+ icon.width + _textPaddingX;
								} else {
									textField.x = _10;
									icon.x = _10 + textField.width + _textPaddingX;
								}
							}
						}
						icon.y = Math.ceil((_2 - icon.height) / 2);
						textField.y = Math.ceil((_2 - textField.height) / 2);
					}
				}
			}else{
				if(textField != null){
					textField.visible = false;
				}
				if(icon != null){
					if(getAutoSize()){
						icon.x = _textPaddingX;
						icon.y = _textPaddingY;
						_1 = _textPaddingX + icon.width + _textPaddingRight;
						_2 = _textPaddingY*2 + icon.height;
					}else{
						icon.x = _textPaddingX + int((_1 - _textPaddingRight - _textPaddingX - icon.width) / 2);
						icon.y = int((_2 - icon.height) / 2);
					}
				}
			}
			if (skin != null) {
				skin.width = _1;
				skin.height = _2;
			}
			if(focusRectSkin != null){
				focusRectSkin.width = _1;
				focusRectSkin.height = _2;
			}
		}
	}
}

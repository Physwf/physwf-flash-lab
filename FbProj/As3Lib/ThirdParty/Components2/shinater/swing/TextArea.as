package shinater.swing{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import shinater.swing.managers.FocusManager;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class TextArea extends Component {
		
		public var textField:TextField;
		
		public var skin:Sprite;
				
		public var horizontalScrollBar:ScrollBar;
		
		public var verticalScrollBar:ScrollBar;
		protected var _width:Number;
		protected var _height:Number;
		protected var _textPaddingX:Number = 1;
		protected var _textPaddingY:Number = 1;
				private var _1:String = "auto";
				private var _2:String = "auto";
		private var _3:TextFormat;
		
		public function TextArea() {
			super();
		}
		protected override function init():void {
			_width = super.width;
			_height = super.height;
			scaleX = scaleY = 1;
			super.init();
			_textPaddingX = textField.x;
			_textPaddingY = textField.y;
			textField.addEventListener(Event.CHANGE,onChanged,false,0,true);
			textField.addEventListener(TextEvent.TEXT_INPUT,onTextInput,false,0,true);
			textField.addEventListener(FocusEvent.FOCUS_IN,onFocusIn,false,0,true);
			textField.addEventListener(FocusEvent.FOCUS_OUT,onFocusOut,false,0,true);
			textField.addEventListener(Event.SCROLL,onScroll,false,0,true);
			horizontalScrollBar.setOrientation(ScrollBar.HORIZONTAL);
			horizontalScrollBar.addEventListener(Event.SCROLL,onScroll,false,0,true);
			verticalScrollBar.setMinScrollPosition(1);
			verticalScrollBar.addEventListener(Event.SCROLL,onScroll,false,0,true);
			addEventListener(FocusEvent.FOCUS_IN,onFocusIn,false,0,true);
			repaint();
		}
		public override function set width(value:Number):void {
			if(_width == value){
				return;
			}
			_width = value;
			repaint();
		}
		public override function set height(value:Number):void {
			if(_width == value){
				return;
			}
			_height = value;
			repaint();
		}
		public override function setSize(width:Number, height:Number):void {
			if(_width == width && _height == height){
				return;
			}
			_width = width;
			_height = height;
			repaint();
		}
		public override function set enabled(value:Boolean):void{
			super.enabled = value;
			repaint();
		}
		public override function get tabChildren():Boolean {
			return false;
		}
		public override function setFocus():void {
			if (getFocusEnabled()) {
				FocusManager.setFocus(textField);
			}
		}
		
		public function setText(text:String):void {
			var _4:Boolean = textField.caretIndex == textField.length;
			textField.text = text;
			if(_4 || stage == null || stage.focus != textField){
				textField.setSelection(text.length,text.length);
			}
			adjustScrollBars();
		}
		
		public function getText():String {
			return textField.text;
		}
		
		public function setHtmlText(text:String):void {
			var _4:Boolean = textField.caretIndex == textField.length;
			textField.htmlText = text;
			if(_4 || stage == null || stage.focus != textField){
				textField.setSelection(text.length,text.length);
			}
			adjustScrollBars();
		}
		
		public function getHtmlText():String {
			return textField.htmlText;
		}
		
		public function setTextColor(color:uint):void {
			textField.textColor = color;
		}
		
		public function getTextColor():uint {
			return textField.textColor;
		}
		
		public function setEditable(editable:Boolean):void {
			textField.type = editable ? TextFieldType.INPUT:TextFieldType.DYNAMIC;
		}
		
		public function getEditable():Boolean {
			return textField.type == TextFieldType.INPUT;
		}
		
		public function getLength():int {
			return textField.length;
		}
		
		public function setMaxChars(maxChars:int):void {
			textField.maxChars = maxChars;
		}
		
		public function getMaxChars():int {
			return textField.maxChars;
		}
		
		public function setRestrict(restrict:String):void {
			textField.restrict = restrict;
		}
		
		public function getRestrict():String {
			return textField.restrict;
		}
		
		public function setWordWrap(wordWrap:Boolean):void {
			textField.wordWrap = wordWrap;
			adjustScrollBars();
		}
		
		public function getWordWrap():Boolean {
			return textField.wordWrap;
		}
		
		public function getCaretIndex():int {
			return textField.caretIndex;
		}
		
		public function getSelectionBeginIndex():int {
			return textField.selectionBeginIndex;
		}
		
		public function getSelectionEndIndex():int {
			return textField.selectionEndIndex;
		}
		
		public function setSelection(beginIndex:int,endIndex:int):void {
			textField.setSelection(beginIndex,endIndex);
		}
		
		public function replaceSelection(content:String):void {
			textField.replaceSelectedText(content);
			adjustScrollBars();
		}
		
		public function replaceText(beginIndex:Number,endIndex:Number,newText:String):void {
			textField.replaceText(beginIndex,endIndex,newText);
			adjustScrollBars();
		}
		
		public function appendText(text:String):void {
			textField.appendText(text);
			adjustScrollBars();
		}
		
		public function setHorizontalScrollPolicy(policy:String):void {
			_1 = policy;
			repaint();
		}
		
		public function getHorizontalScrollPolicy():String {
			return _1;
		}
		
		public function setHorizontalScrollPosition(position:int):void {
			textField.scrollH = position;
			horizontalScrollBar.setScrollPosition(position);
		}
		
		public function getHorizontalScrollPosition():int {
			return textField.scrollH;
		}
		
		public function getMaxHorizontalScrollPosition():int {
			return textField.maxScrollH;
		}
		
		public function setVerticalScrollPolicy(policy:String):void {
			_2 = policy;
			repaint();
		}
		
		public function getVerticalScrollPolicy():String {
			return _2;
		}
		
		public function setVerticalScrollPosition(position:int):void {
			textField.scrollV = position;
			verticalScrollBar.setScrollPosition(position);
		}
		
		public function getVerticalScrollPosition():int {
			return textField.scrollV;
		}
		
		public function getMaxVerticalScrollPosition():int {
			return textField.maxScrollV;
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		protected function onChanged(evt:Event):void {
			adjustScrollBars();
			evt.stopPropagation();
			dispatchEvent(evt);
		}
		
		[Event(name = "textInput",type = "flash.events.TextEvent")]
		protected function onTextInput(evt:TextEvent):void {
			evt.stopPropagation();
			if (! dispatchEvent(evt)) {
				evt.preventDefault();
			}
		}
		
		[Event(name = "focusIn",type = "flash.events.FocusEvent")]
		protected function onFocusIn(evt:FocusEvent):void {
			if(evt.currentTarget == textField){
				evt.stopPropagation();
				dispatchEvent(evt);
			}else{
				stage.focus = textField;
			}
		}
		
		[Event(name = "focusOut",type = "flash.events.FocusEvent")]
		protected function onFocusOut(evt:FocusEvent):void {
			evt.stopPropagation();
			dispatchEvent(evt);
		}
		protected function onScroll(evt:Event):void {
						if (evt.currentTarget == textField) {
				var _4:int = textField.scrollH;
				var _5:int = textField.scrollV;
				if(int(horizontalScrollBar.getScrollPosition()) != _4){
					horizontalScrollBar.setScrollPosition(_4);
				}
				if(int(verticalScrollBar.getScrollPosition()) != _5){
					verticalScrollBar.setScrollPosition(_5);
				}
			} else if (evt.currentTarget == horizontalScrollBar) {
				_4 = horizontalScrollBar.getScrollPosition();
				if (textField.scrollH != _4) {
					textField.scrollH = _4;
				}
			} else if (evt.currentTarget == verticalScrollBar) {
				_5 = verticalScrollBar.getScrollPosition();
				if (textField.scrollV != _5) {
					textField.scrollV = _5;
				}
			}
		}
		private function adjustScrollBars():void {
			var _4:Boolean = _1 == "auto";
			var _5:Number = horizontalScrollBar.height;
			var _6:Number = verticalScrollBar.width;
			if (_4){
				if(textField.maxScrollH > 0){
					if(!horizontalScrollBar.visible){
						textField.height -= _5;
						horizontalScrollBar.visible = true;
					}
				}else{
					if(horizontalScrollBar.visible){
						textField.height += _5;
						horizontalScrollBar.visible = false;
					}
				}
			}
			if (_2 == "auto"){
				if(textField.maxScrollV > 1){
					if(!verticalScrollBar.visible){
						textField.width -= _6;
						if(_4 && !horizontalScrollBar.visible && textField.maxScrollH > 0){
							textField.height -= _5;
							horizontalScrollBar.visible = true;
						}
						verticalScrollBar.visible = true;
					}
				}else{
					if(verticalScrollBar.visible){
						textField.width += _6;
						if(_4 && horizontalScrollBar.visible && textField.maxScrollH == 0){
							textField.height += _5;
							horizontalScrollBar.visible = true;
						}
						verticalScrollBar.visible = false;
					}
				}
			}
			var _7:Number = _width;
			var _8:Number = _height;
			if(horizontalScrollBar.visible){
				horizontalScrollBar.width = _7 - horizontalScrollBar.x*2 - (verticalScrollBar.visible ? _6 : 0);
				if(enabled && textField.maxScrollH > 0){
					horizontalScrollBar.setEnabled(true);
					horizontalScrollBar.setPageScrollSize(textField.width);
					horizontalScrollBar.setMaxScrollPosition(textField.maxScrollH);
					horizontalScrollBar.setScrollPosition(textField.scrollH);
				}else{
					horizontalScrollBar.setEnabled(false);
				}
			}
			if(verticalScrollBar.visible){
				verticalScrollBar.height = _8 - verticalScrollBar.y*2 - (horizontalScrollBar.visible ? _5 : 0);
				if(enabled && textField.maxScrollV > 1){
					verticalScrollBar.setEnabled(true);
					verticalScrollBar.setPageScrollSize(textField.bottomScrollV - textField.scrollV + 1);
					verticalScrollBar.setMaxScrollPosition(textField.maxScrollV);
					verticalScrollBar.setScrollPosition(textField.scrollV);
				}else{
					verticalScrollBar.setEnabled(false);
				}
			}
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _4:Number = _width;
			var _5:Number = _height;
			var _6:TextFormat = enabled ? getTextFormat() : getDisabledTextFormat();
			if(_6 != null){
				if(_3 == null){
					_3 = textField.defaultTextFormat;
				}
				textField.defaultTextFormat = _6;
			}else if(_3 != null){
				textField.defaultTextFormat = _3;
				_3 = null;
			}
			var _7:Number = horizontalScrollBar.height;
			var _8:Number = verticalScrollBar.width;
			if (_1 == "on") {
				textField.height = _5 - horizontalScrollBar.x - _7 - _textPaddingY;
				horizontalScrollBar.visible = true;
			} else {
				textField.height = _5 - _textPaddingY * 2 + 1;
				horizontalScrollBar.visible = false;
			}
			if (_2 == "on") {
				textField.width = _4 - verticalScrollBar.y - _8 - _textPaddingX;
				verticalScrollBar.visible = true;
			} else {
				textField.width = _4 - _textPaddingX * 2 + 1;
				verticalScrollBar.visible = false;
			}
			horizontalScrollBar.y = _5 - _7 - horizontalScrollBar.x;
			horizontalScrollBar.setLineScrollSize(5);
			verticalScrollBar.x = _4 - _8 - verticalScrollBar.y;
			verticalScrollBar.setMinScrollPosition(1);
			verticalScrollBar.setLineScrollSize(1);
			adjustScrollBars();
			if (skin != null){
				skin.width = _4;
				skin.height = _5;
			}
			if (focusRectSkin != null) {
				focusRectSkin.width = _4;
				focusRectSkin.height = _5;
			}
		}
	}
}

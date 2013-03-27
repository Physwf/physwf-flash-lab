package shinater.swing{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.events.FocusEvent;
	import shinater.swing.managers.FocusManager;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class TextInput extends Component {
		
		public var textField:TextField;
		
		public var skin:Sprite;
				protected var _width:Number;
		protected var _height:Number;
		protected var _textPaddingX:Number = 0;
		protected var _textPaddingY:Number = 0;
		private var _1:TextFormat;
		
		public function TextInput() {
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
			var _2:Boolean = textField.caretIndex == textField.length;
			textField.text = text;
			if(_2 || stage == null || stage.focus != textField){
				textField.setSelection(text.length,text.length);
			}
		}
		
		public function getText():String {
			return textField.text;
		}
		
		public function setHtmlText(text:String):void {
			var _2:Boolean = textField.caretIndex == textField.length;
			textField.htmlText = text;
			if(_2 || stage == null || stage.focus != textField){
				textField.setSelection(text.length,text.length);
			}
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
		
		public function setAlignment(alignment:String):void {
			var _2:TextFormat = textField.defaultTextFormat;
			_2.align = alignment;
			textField.defaultTextFormat = _2;
		}
		
		public function getAlignment():String {
			return textField.defaultTextFormat.align;
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
		
		
		
		public function setDisplayAsPassword(displayAsPassword:Boolean):void {
			textField.displayAsPassword = displayAsPassword;
		}
		
		public function getDisplayAsPassword():Boolean {
			return textField.displayAsPassword;
		}
		
		public function setRestrict(restrict:String):void {
			textField.restrict = restrict;
		}
		
		public function getRestrict():String {
			return textField.restrict;
		}
		
		
		
		public function setHorizontalScrollPosition(position:int):void {
			textField.scrollH = position;
		}
		
		public function getHorizontalScrollPosition():int {
			return textField.scrollH;
		}
		
		
		public function getMaxHorizontalScrollPosition():int {
			return textField.maxScrollH;
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
		}
		
		public function replaceText(beginIndex:int,endIndex:int,newText:String):void {
			textField.replaceText(beginIndex,endIndex,newText);
		}
		
		
		
		
		
		
		
		
		
		
		[Event(name = "change",type = "flash.events.Event")]
		protected function onChanged(evt:Event):void {
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
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _2:Number = _width;
			var _3:Number = _height;
			textField.width = int(_2 - _textPaddingX * 2);
			textField.height = int(_3 - _textPaddingY * 2);
			var _4:TextFormat = enabled ? getTextFormat() : getDisabledTextFormat();
			if(_4 != null){
				if(_1 == null){
					_1 = textField.defaultTextFormat;
				}
				textField.defaultTextFormat = _4;
			}else if(_1 != null){
				textField.defaultTextFormat = _1;
				_1 = null;
			}
			if (skin != null){
				skin.width = _2;
				skin.height = _3;
			}
			if (focusRectSkin != null) {
				focusRectSkin.width = _2;
				focusRectSkin.height = _3;
			}
		}
	}
}

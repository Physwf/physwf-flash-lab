package shinater.swing{
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.events.KeyboardEvent;
	import flash.events.FocusEvent;
	import flash.ui.Keyboard;
	import shinater.swing.managers.FocusManager;
	import shinater.swing.managers.StyleManager;

	
	public dynamic class ColorPicker extends Component {
		
		public var previewSwatch:Sprite;
		
		public var textField:TextInput;
		
		public var swatchSelectedSkin:Sprite;
		
		public var skin:Sprite;
		private var _1:Array;
		private var _2:uint = 0;
		private var _3:int = 20;
		private var _4:Number;
		private var _5:Number;
		private var _6:Sprite;
		protected var _contentPadding:Number = 0;
		
		public function ColorPicker(){
			super();
		}
		protected override function init():void{
			super.init();
			if(previewSwatch != null){
				_contentPadding = previewSwatch.y;
			}else if(textField != null){
				_contentPadding = textField.y;
			}else{
				_contentPadding = swatchSelectedSkin.y + 1;
			}
			_4 = swatchSelectedSkin.width - 2;
			_5 = swatchSelectedSkin.height - 2;
			_6 = new Sprite();
			_6.addChild(swatchSelectedSkin);
			_6.addEventListener(MouseEvent.MOUSE_MOVE,onSwatchesOver,false,0,true);
			_6.addEventListener(MouseEvent.ROLL_OUT,onSwatchesOut,false,0,true);
			_6.addEventListener(MouseEvent.MOUSE_DOWN,onSwatchesDown,false,0,true);
			addChild(_6);
			if(textField != null){
				textField.setRestrict("#A-Fa-f0-9");
				textField.setMaxChars(7);
				textField.tabEnabled = false;
				textField.setFocusEnabled(false);
				textField.addEventListener(Event.CHANGE,onTextFieldChanged,false,0,true);
				textField.addEventListener(KeyboardEvent.KEY_DOWN,onTextFieldKeyDown,false,0,true);
				textField.addEventListener(FocusEvent.FOCUS_OUT,onTextFieldFocusOut,false,0,true);
				addEventListener(FocusEvent.FOCUS_IN,onFocusIn,false,0,true);
			}
			_1 = new Array();
			var baseColors = [0x000000, 0x333333, 0x666666, 0x999999, 0xCCCCCC, 0xFFFFFF, 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0x00FFFF, 0xFF00FF];
			for(var _7:int = 0; _7 < 12; _7++){
				_1.push(baseColors[_7]);
				_1.push(0x000000);
				for(var _8:int = 0; _8 < 18; _8++){
					_1.push((((_7*3+_8/6)%3<<0)+((_7/6)<<0)*3)*0x33<<16 | _8%6*0x33<<8  | (_7<<0)%6*0x33);
				}
			}
			setSelectedColor(0);
			repaint();
		}
		public override function set width(value:Number):void{
		}
		public override function set height(value:Number):void{
		}
		public override function getFocusEnabled():Boolean {
			if(textField == null){
				return false;
			}
			return super.getFocusEnabled();
		}
		public override function setFocus():void {
			if (getFocusEnabled()) {
				FocusManager.setFocus(textField.textField);
			}
		}
		public override function drawFocus(focused:Boolean):void {
			if(textField != null){
				textField.drawFocus(focused);
			}
		}
		
		public function setColors(colors:Array):void{
			_1 = colors;
			repaint();
		}
		
		public function getColors():Array{
			return _1;
		}
		
		public function setSelectedColor(color:uint):void{
			_2 = color;
			preview(color);
			selectSwatch(color);
			if(textField != null){
				textField.setText("#" + getHexValue());
			}
		}
		
		public function getSelectedColor():uint{
			return _2;
		}
		
		public function getHexValue():String{
			var _7:String = _2.toString(16);
			return "00000".substr(0,6-_7.length) + _7.toUpperCase();
		}
		
		public function setSwatchSize(width:Number, height:Number):void{
			_4 = width;
			_5 = height;
			repaint();
		}
		
		public function getSwatchWidth():Number{
			return _4;
		}
		
		public function getSwatchHeight():Number{
			return _5;
		}
		
		public function setColumnCount(count:int):void{
			_3 = count;
			repaint();
		}
		
		public function getColumnCount():int{
			return _3;
		}
		private function preview(color:uint):void{
			var _7:Number = previewSwatch.width;
			var _8:Number = previewSwatch.height;
			var _9:Graphics = previewSwatch.graphics;
			_9.clear();
			_9.beginFill(color,1);
			_9.drawRect(0,0,_7,_8);
			_9.endFill();
		}
		private function selectSwatch(color:uint):void{
			var _7:int = _1.indexOf(color);
			if(_7 != -1){
				var _8:int = _7%_3;
				var _9:int = int(_7/_3);
				swatchSelectedSkin.visible = true;
				swatchSelectedSkin.x = _8 * (_4+1);
				swatchSelectedSkin.y = _9 * (_5+1);
			}else{
				swatchSelectedSkin.visible = false;
			}
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		protected function onSwatchesOver(evt:MouseEvent):void{
			var _7:Number = _6.mouseX;
			var _8:Number = _6.mouseY;
			var _9:int = int(_7/(_4+1));
			if(_9 >= 0 && _9 < _3){
				var _10:int = int(_8/(_5+1));
				var _11:int = _10 * _3 + _9;
				if(_11 >= 0 && _11 < _1.length){
					var _12:uint = _1[_11];
					if(textField != null){
						var _13:String = _12.toString(16);
						_13 = "#" + "00000".substr(0,6-_13.length) + _13.toUpperCase();
						textField.setText(_13);
					}
					preview(_12);
				}
			}
		}
		protected function onSwatchesOut(evt:MouseEvent):void{
			preview(_2);
			if(textField != null){
				textField.setText("#" + getHexValue());
			}
		}
		protected function onSwatchesDown(evt:MouseEvent):void{
			var _7:Number = _6.mouseX;
			var _8:Number = _6.mouseY;
			var _9:int = int(_7/(_4+1));
			var _10:int = int(_8/(_5+1));
			var _11:int = _10 * _3 + _9;
			if(_11 >= 0 && _11 < _1.length){
				var _12:uint = _1[_11];
				if(_12 != _2){
					setSelectedColor(_12);
					dispatchEvent(new Event(Event.CHANGE,false));
				}
			}
		}
		protected function onFocusIn(evt:FocusEvent):void{
			if(stage.focus != textField.textField){
				stage.focus = textField.textField;
			}
		}
		protected function onTextFieldKeyDown(evt:KeyboardEvent):void{
			if(evt.keyCode == Keyboard.ENTER){
				var _7:String = textField.getText();
				onTextFieldFocusOut(null);
				if(textField.getText() != _7){
					textField.setSelection(textField.getLength(),textField.getLength());
				}
			}
		}
		protected function onTextFieldChanged(evt:Event):void{
			var _7:String = textField.getText();
			var _8:int = _7.indexOf("#",1);
			if(_8 != -1){
				textField.setText(_7.charAt(0) + _7.substr(1).replace(/#/g, ""));
			}
			_7 = _7.replace(/#/g, "");
			if(_7.length > 6){
				_7 = _7.substr(0,6);
			}
			var _9:int = parseInt(_7,16);
			if(isNaN(_9)){
				_9 = 0;
			}
			preview(_9);
			evt.stopPropagation();
		}
		protected function onTextFieldFocusOut(evt:FocusEvent):void{
			var _7:String = textField.getText();
			if(_7.indexOf("#") != -1){
				_7 = _7.replace(/#/g, "");
			}
			if(_7.length > 6){
				_7 = _7.substr(0,6);
			}
			var _8:int = parseInt(_7,16);
			if(isNaN(_8)){
				_8 = 0;
			}
			if(_8 != _2){
				setSelectedColor(_8);
				dispatchEvent(new Event(Event.CHANGE,false));
			}else{
				_7 = "#" + getHexValue();
				if(textField.getText() != _7){
					textField.setText(_7);
				}
			}
		}
		public override function repaint():void{
			
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _7:Number = _contentPadding;
			var _8:Number = _contentPadding;
			if(previewSwatch != null){
				previewSwatch.x = _7;
				previewSwatch.y = _8;
				if(textField != null){
					textField.y = _8 + Math.ceil((previewSwatch.height-textField.height)/2);
					textField.repaint();
				}
				_8 += previewSwatch.height + _contentPadding;
			}else if(textField != null){
				textField.x = _7;
				textField.y = _8;
				textField.repaint();
				_8 += textField.height + _contentPadding;
			}
			_6.x = _7 - 1;
			_6.y = _8;
			var _9:Graphics = _6.graphics;
			_9.clear();
			for(var _10:int = 0,_11:uint = _1.length; _10 < _11; _10++){
				_7 = (_10%_3) * (_4+1);
				_8 = int(_10/_3) * (_5+1);
				_9.beginFill(0x000000);
				_9.drawRect(_7,_8,_4+2,_5+2);
				_9.endFill();
				_9.beginFill(_1[_10]);
				_9.drawRect(_7+1,_8+1,_4,_5);
				_9.endFill();
			}
			preview(_2);
			selectSwatch(_2);
			skin.width = _6.width + _contentPadding*2 - 2;
			skin.height = _6.y + _6.height + _contentPadding;
		}
	}
}

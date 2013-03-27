package shinater.swing{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class DataGridCellRenderer extends ToggleButton implements IDataGridCellRenderer {
		private var _1:Component;
		private var _2:int;
		private var _3:int;
		private var _4:int;
		private var _5:Object;
		private var _6:Boolean;
		private var _7:Boolean;
		private var _8:uint;
		
		public var editorSkin:Sprite;
		
		public function DataGridCellRenderer() {
			super();
		}
		protected override function init():void{
			super.init();
			editorSkin.visible = false;
			editorSkin.useHandCursor = false;
			addEventListener(FocusEvent.FOCUS_IN,onFocusIn,false,0,true);
			addEventListener(FocusEvent.FOCUS_OUT,onFocusOut,false,0,true);
		}
		public override function setLabelPlacement(placement:String):void {
		}
		public override function getFocusEnabled():Boolean{
			return _6;
		}
		public override function getTextFormat():TextFormat {
			var _9:TextFormat = super.getTextFormat();
			if(_9 != null){
				return _9;
			}
			var _10:DisplayObjectContainer = parent;
			while(_10 != null && _10 != root){
				if(_10 is Component){
					_9 = Component(_10).getTextFormat();
					if(_9 != null){
						return _9;
					}
					if(_10 is DataGrid){
						break;
					}
				}
				_10 = _10.parent;
			}
			return null;
		}
		public override function getDisabledTextFormat():TextFormat {
			var _9:TextFormat = super.getDisabledTextFormat();
			if(_9 != null){
				return _9;
			}
			var _10:DisplayObjectContainer = parent;
			while(_10 != null && _10 != root){
				if(_10 is Component){
					_9 = Component(_10).getDisabledTextFormat();
					if(_9 != null){
						return _9;
					}
					if(_10 is DataGrid){
						break;
					}
				}
				_10 = _10.parent;
			}
			return null;
		}
		
		public function setOwner(dataGrid:Component):void {
			_1 = dataGrid;
		}
		
		public function getOwner():Component {
			return _1;
		}
		
		public function setIndex(index:int):void {
			_2 = index;
		}
		
		public function getIndex():int {
			return _2;
		}
		
		public function setColumn(column:int):void{
			_3 = column;
		}
		
		public function getColumn():int{
			return _3;
		}
		
		public function setRow(row:int):void{
			_4 = row;
		}
		
		public function getRow():int{
			return _4;
		}
		
		public function setData(data:Object):void {
			_5 = data;
		}
		
		public function getData():Object {
			return _5;
		}
		
		public function setEditable(editable:Boolean):void{
			_6 = editable;
		}
		
		public function getEditable():Boolean{
			return _6;
		}
		protected override function onMouseDown(evt:MouseEvent):void{
			if(_7){
				return;
			}
			_selected = ! _selected;
			super.onMouseDown(evt);
		}
		protected override function onClick(evt:MouseEvent):void {
		}
		protected function onFocusIn(evt:FocusEvent):void{
			if(!_6 || _7){
				evt.stopImmediatePropagation();
				return;
			}
						_8 = textField.textColor;
			textField.textColor = 0x000000;
			textField.type = TextFieldType.INPUT;
			textField.selectable = true;
			textField.setSelection(0,textField.length);
			textField.addEventListener(Event.CHANGE,onTextChanged,false,0,true);
			editorSkin.visible = true;
			mouseChildren = true;
			_7 = true;
			stage.focus = textField;
		}
		protected function onFocusOut(evt:FocusEvent):void{
			if(!_6 || evt.relatedObject == textField){
				evt.stopImmediatePropagation();
				return;
			}
			textField.type = TextFieldType.DYNAMIC;
			textField.selectable = false;
			textField.removeEventListener(Event.CHANGE,onTextChanged);
			textField.textColor = _8;
			editorSkin.visible = false;
			mouseChildren = false;
			_7 = false;
			setMouseState(_mouseState);
		}
		protected function onTextChanged(evt:Event):void{
			_5 = textField.text;
		}
		protected override function onKeyDown(evt:KeyboardEvent):void {
		}
		protected override function onKeyUp(evt:KeyboardEvent):void {
		}
		public override function setMouseState(state:String):void {
			_mouseState = state = state.toLowerCase();
			if(_7){
				return;
			}
			super.setMouseState(state);
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _9:Number = _width;
			var _10:Number = _height;
			var _11:Number = _textPaddingX;
			if(icon != null){
				icon.x = _11;
				icon.y = Math.ceil((_10-icon.height)/2);
				_11 += _10;
			}
			textField.x = _11;
			textField.width = _9 - _textPaddingX*2;
			var _12:String = getLabel();
			if(_12 != null){
				textField.htmlText = _12;
				var _13:TextFormat = enabled ? getTextFormat() : getDisabledTextFormat();
				if(_13 != null){
					textField.setTextFormat(_13);
				}
			}
			textField.y = Math.ceil((_10-textField.height)/2);
			skin.width = _9;
			skin.height = _10;
			if(editorSkin != null){
				editorSkin.width = _9;
				editorSkin.height = _10;
			}
			if(focusRectSkin != null){
				focusRectSkin.width = _9;
				focusRectSkin.height = _10;
			}
		}
	}
}

package shinater.swing{
	import flash.display.DisplayObject;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.FocusEvent;
	import flash.ui.Keyboard;
	import shinater.swing.ICellRenderer;
	import shinater.swing.managers.FocusManager;
	import shinater.swing.managers.PopUpManager;
	import shinater.swing.managers.StyleManager;

	
	public dynamic class ComboBox extends Component{
		
		public var textField:TextInput;
		
		public var downArrow:Button;
		
		public var dropdown:List;
		private var _1:Boolean = true;
		private var _2:uint = 5;
		private var _3:Number;
		private var _4:Number;
		
		public function ComboBox() {
			super();
		}
		protected override function init():void {
			_3 = super.width;
			_4 = super.height;
			scaleX = scaleY = 1;
			super.init();
			if(dropdown == null){
				dropdown = new List();
			}
			dropdown.visible = false;
			dropdown.addEventListener(Event.CHANGE,onSelectionChanged,false,0,true);
			dropdown.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown,false,0,true);
						dropdown.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,1,true);
			dropdown.addEventListener("hide",onDropdownHide,false,0,true);
			downArrow.tabEnabled = false;
			downArrow.setFocusEnabled(false);
			downArrow.addEventListener(MouseEvent.MOUSE_DOWN,onDownArrow,false,0,true);
			textField.tabEnabled = false;
			textField.setFocusEnabled(false);
			textField.addEventListener(Event.CHANGE,onTextChanged,false,0,true);
			addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
						setEditable(false)
					}
		public override function set enabled(value:Boolean):void{
			super.enabled = value;
			textField.enabled = value;
			downArrow.enabled = value;
		}
		public override function set width(value:Number):void {
			if(_3 == value){
				return;
			}
			_3 = value;
			repaint();
		}
		public override function get width():Number {
			return _3;
		}
		public override function set height(value:Number):void {
			if(_4 == value){
				return;
			}
			_4 = value;
			repaint();
		}
		public override function get height():Number {
			return _4;
		}
		public override function setSize(width:Number,height:Number):void {
			if(_3 == width && _4 == height){
				return;
			}
			_3 = width;
			_4 = height;
			repaint();
		}
		public override function setTextFormat(textFormat:TextFormat):void {
			textField.setTextFormat(textFormat);
		}
		public override function getTextFormat():TextFormat {
			return textField.getTextFormat();
		}
		public override function setDisabledTextFormat(textFormat:TextFormat):void {
			textField.setDisabledTextFormat(textFormat);
		}
		public override function getDisabledTextFormat():TextFormat {
			return textField.getDisabledTextFormat();
		}
		public override function setFocus():void {
			if (getFocusEnabled()) {
				FocusManager.setFocus(getEditable() ? textField.textField : this);
			}
		}
		public override function drawFocus(focused:Boolean):void {
			if (focusRectSkin != null){
				super.drawFocus(focused);
				return;
			}
			if (! getEditable()) {
				downArrow.drawFocus(focused);
			} else {
				textField.drawFocus(focused);
			}
		}
		
		public function setEditable(editable:Boolean):void {
			if (_1 == editable) {
				return;
			}
			_1 = editable;
			textField.setEditable(editable);
			textField.textField.selectable = editable;
			if (! editable) {
				textField.addEventListener(MouseEvent.ROLL_OVER,onRollOver,false,0,true);
				textField.addEventListener(MouseEvent.ROLL_OUT,onRollOut,false,0,true);
				textField.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown,false,0,true);
				removeEventListener(FocusEvent.FOCUS_IN,onFocusIn);
			} else {
				textField.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
				textField.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
				textField.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				addEventListener(FocusEvent.FOCUS_IN,onFocusIn,false,0,true);
				dropdown.addEventListener(FocusEvent.FOCUS_IN,onFocusIn,false,0,true);
			}
			repaint();
		}
		
		public function getEditable():Boolean {
			return textField.getEditable();
		}
		
		public function setText(text:String):void {
			if (! getEditable()) {
				return;
			}
			textField.setText(text);
			if (dropdown.getSelectedIndex() != -1) {
				dropdown.setSelectedIndex(-1);
			}
		}
		
		public function getText():String {
			return textField.getText();
		}
		
		public function setRestrict(restrict:String):void {
			textField.setRestrict(restrict);
		}
		
		public function getRestrict():String {
			return textField.getRestrict();
		}
		
		public function setMaximumRowCount(count:uint):void {
			setRowCount(count);
		}
		
		public function getMaximumRowCount():uint {
			return getRowCount();
		}
		
		public function setRowCount(count:uint):void {
			_2 = count;
		}
		
		public function getRowCount():uint {
			return _2;
		}
		
		public function setDataProvider(dataProvider:Array):void {
			if (dropdown.getSelectedIndex() != -1) {
				textField.setText("");
			}
			dropdown.setDataProvider(dataProvider);
			if (dataProvider != null && dataProvider.length > 0 && ! getEditable()) {
				setSelectedIndex(0);
				repaint();
			}
		}
		
		public function getDataProvider():Array {
			return dropdown.getDataProvider();
		}
		
		public function addItem(item:Object):void {
			addItemAt(item,getLength());
		}
		
		public function addItemAt(item:Object,index:uint):void {
			dropdown.addItemAt(item,index);
			if (dropdown.getLength() == 1 && ! getEditable()) {
				setSelectedIndex(0);
				repaint();
			}
		}
		
		public function getItemAt(index:uint):Object {
			return dropdown.getItemAt(index);
		}
		
		public function getItemCount():Number {
			return getLength();
		}
		
		public function getLength():uint {
			return dropdown.getLength();
		}
		
		public function removeItem(item:Object):Object {
			var _5:int = dropdown.getSelectedIndex();
			var _6:Object = dropdown.removeItem(item);
			if (_5 != -1 && dropdown.getSelectedIndex() == -1) {
				textField.setText("");
			}
			return _6;
		}
		
		public function removeItemAt(index:uint):Object {
			if (index >= 0 && dropdown.getSelectedIndex() == index) {
				textField.setText("");
			}
			var _5:Object = dropdown.removeItemAt(index);
			return _5;
		}
		
		public function removeAll():void {
			if (dropdown.getSelectedIndex() != -1) {
				textField.setText("");
			}
			dropdown.removeAll();
		}
		
		public function replaceItemAt(item:Object,index:uint):void {
			dropdown.replaceItemAt(item,index);
			if (dropdown.getSelectedIndex() == index) {
				textField.setText(dropdown.itemToCellRenderer(item).getLabel());
			}
		}
		
		public function sortItems(... sortArgs):void {
			dropdown.sortItems(sortArgs);
		}
		
		
		public function sortItemsOn(field:String,options:Object=null):void {
			dropdown.sortItemsOn(field,options);
		}
				
		public function setSelectedIndex(index:uint):void {
			dropdown.setSelectedIndex(index);
			onSelectionChanged(null);
		}
		
		public function getSelectedIndex():int {
			return dropdown.getSelectedIndex();
		}
		
		public function setSelectedItem(item:Object):void {
			dropdown.setSelectedItem(item);
			onSelectionChanged(null);
		}
		
		public function getSelectedItem():Object {
			return dropdown.getSelectedItem();
		}
				
		public function close():void {
			hidePopup();
		}
		
		public function open():void {
			downArrow.setMouseState("down");
			showPopup();
		}
		private function showPopup():void {
			var _5:uint = Math.min(getRowCount(),getLength());
			if(dropdown.getRowCount() != _5){
				dropdown.setRowCount(_5);
			}
			PopUpManager.show(dropdown,this,0,_4);
			downArrow.mouseEnabled = false;
					}
		private function hidePopup():void {
			PopUpManager.hide(dropdown);
			downArrow.mouseEnabled = true;
					}
				
		[Event(name = "change",type = "flash.events.Event")]
		
		
		
		protected function onDownArrow(evt:MouseEvent):void {
			showPopup();
		}
		protected function onRollOver(evt:MouseEvent):void {
			if (downArrow.mouseEnabled) {
				downArrow.dispatchEvent(evt);
			}
		}
		protected function onRollOut(evt:MouseEvent):void {
			if (downArrow.mouseEnabled) {
				downArrow.dispatchEvent(evt);
			}
		}
		protected function onMouseDown(evt:MouseEvent):void {
			downArrow.dispatchEvent(evt);
		}
		protected function onSelectionChanged(evt:Event):void {
			if (dropdown.getSelectedIndex() != -1) {
				var _5:String = dropdown.itemToCellRenderer(dropdown.getSelectedItem()).getLabel();
				textField.setText(_5);
				textField.setSelection(_5.length,_5.length);
							}
			if (evt != null){
				dispatchEvent(evt);
			}
		}
		protected function onItemDown(evt:MouseEvent):void {
			var _5:DisplayObject = DisplayObject(evt.target);
			while(_5 != dropdown){
				if(_5 is ICellRenderer){
					dropdown.addEventListener(MouseEvent.MOUSE_UP,onDropdownUp,false,0,true);
					return;
				}
				_5 = _5.parent;
			}
		}
		protected function onDropdownUp(evt:Event):void {
			dropdown.removeEventListener(MouseEvent.MOUSE_UP,onDropdownUp);
			hidePopup();
		}
		protected function onDropdownHide(evt:Event):void {
			downArrow.mouseEnabled = true;
		}
		protected function onTextChanged(evt:Event):void {
			if (dropdown.getSelectedIndex() != -1) {
				dropdown.setSelectedIndex(-1);
			}
			
		}
		protected function onFocusIn(evt:FocusEvent):void{
						if(stage.focus != textField.textField){
				stage.focus = textField.textField;
			}
		}
		
		protected function onKeyDown(evt:KeyboardEvent):void {
						if (evt.keyCode == Keyboard.ENTER || evt.keyCode == Keyboard.ESCAPE) {
				if (dropdown.visible) {
					hidePopup();
					evt.stopPropagation();
				}
				return;
			}
			if (evt.ctrlKey){
				if(evt.keyCode == Keyboard.UP){
					if (dropdown.visible) {
						close();
					}
				}else if(evt.keyCode == Keyboard.DOWN){
					if (!dropdown.visible) {
						open();
					}
				}
				evt.stopPropagation();
				return;
			}
			if (evt.currentTarget == this) {
				dropdown.dispatchEvent(evt);
			}
		}
		public override function repaint():void {
						if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			if (textField.width != _3) {
				textField.width = _3;
				downArrow.x = _3 - downArrow.y - downArrow.width;
				textField.textField.width =  downArrow.x - textField.textField.x;
			}
			dropdown.width = _3;
			if (textField.height != _4) {
				textField.height = _4;
				downArrow.height = _4 - downArrow.y * 2;
			}
									if(focusRectSkin != null){
				focusRectSkin.width = _3;
				focusRectSkin.height = _4;
			}
		}
	}
}

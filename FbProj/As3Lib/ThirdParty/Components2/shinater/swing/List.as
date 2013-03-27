package shinater.swing{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Rectangle;

	
	public dynamic class List extends ScrollPane {
				protected var _cellRenderer:Class;
				protected var _dataProvider:Array = [];
		protected var _cellRenderers:Array = [];
				private var _1:Boolean = false;
				private var _2:Boolean = true;
				protected var _selectedIndex:int = -1;
		protected var _lastSelectedIndex:int = -1;
				protected var _selectedIndices:Array = [];
		protected var _focusIndex:int = -1;
		private var _3:Number = -1;
		private var _4:Boolean = false;
		private var _5:Boolean = false;
		protected var _mousePressed:Boolean = false;
		public var content:Panel;
		
		public function List() {
			super();
		}
		protected override function init():void {
			super.init();
			_vLineScrollSize = 0;
			_contentPaddingX = content.x;
			_contentPaddingY = content.y;
			content.tabEnabled = false;
			content.setFocusEnabled(false);
			tabChildren = false;
			setCellRenderer(ListCellRenderer);
		}
		public override function get tabChildren():Boolean{
			return false;
		}
		public override function drawFocus(focused:Boolean):void {
			if (focusRectSkin != null) {
				if(focusRectSkin.visible != focused){
					focusRectSkin.visible = focused;
				}
				return;
			}
			
		}
		public override function setContent(content:DisplayObject):void {
		}
		public override function getContent():DisplayObject {
			return content;
		}
		
		public function setCellRenderer(cellRenderer:Class):void {
			var _6:DisplayObject = DisplayObject(ICellRenderer(new cellRenderer()));
			if (!_4) {
				_3 = _6.height;
			}
			_cellRenderer = cellRenderer;
			repaint();
		}
		
		public function getCellRenderer():Class {
			return _cellRenderer;
		}
		
		public function setMultipleSelection(selectable:Boolean):void {
			if (_1 == selectable) {
				return;
			}
			if (! selectable) {
				if (_selectedIndices.length > 1) {
					setSelectedIndices([_selectedIndices[_selectedIndices.length - 1]]);
				}
			} else {
				_selectedIndices.splice(0);
				if (_selectedIndex != -1) {
					_selectedIndices.push(_selectedIndex);
				}
			}
			_1 = selectable;
		}
		
		public function getMultipleSelection():Boolean {
			return _1;
		}
		
		public function setSelectable(selectable:Boolean):void {
			if (! selectable) {
				clearSelection();
			}
			_2 = selectable;
		}
		
		public function getSelectable():Boolean {
			return _2;
		}
		
		public function setDataProvider(dataProvider:Array):void {
			removeAll();
			for (var _6:int = 0,_7:uint = dataProvider.length; _6 < _7; _6++) {
				var _8:Object = dataProvider[_6];
				_dataProvider.push(_8);
				var _9:DisplayObject = DisplayObject(createCellRenderer(_8,_6));
				_9.addEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown,false,1,true);
				_9.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown,false,0,true);
				_9.addEventListener(MouseEvent.ROLL_OVER,onItemOver,false,0,true);
				content.addChild(_9);
				_cellRenderers.push(_9);
			}
			repaint();
		}
		
		public function getDataProvider():Array {
			return _dataProvider.slice();
		}
		
		public function addItem(item:Object):void {
			addItemAt(item,getLength());
		}
		
		public function addItemAt(item:Object,index:uint):void {
			_dataProvider.splice(index,0,item);
			var _6:DisplayObject = DisplayObject(createCellRenderer(item,index));
			_6.addEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown,false,1,true);
			_6.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown,false,0,true);
			_6.addEventListener(MouseEvent.ROLL_OVER,onItemOver,false,0,true);
			var _7:uint;
			if (_cellRenderers.length > 0 && index < _cellRenderers.length) {
				_7 = content.getChildIndex(_cellRenderers[index]);
			} else {
				_7 = content.numChildren;
			}
			content.addChildAt(_6,_7);
			_cellRenderers.splice(index,0,_6);
			for (var _8:int = index+1,_9:uint = _cellRenderers.length; _8 < _9; _8++){
				_cellRenderers[_8].setIndex(_8);
			}
			for (_8 = 0,_9 = _selectedIndices.length; _8 < _9; _8++) {
				if (_selectedIndices[_8] >= index) {
					_selectedIndices[_8] += 1;
				}
			}
			if (_selectedIndex >= index) {
				_selectedIndex++;
			}
			if (_lastSelectedIndex >= index) {
				_lastSelectedIndex++;
			}
			if (_focusIndex >= index) {
				_focusIndex++;
			}
			repaint();
		}
		
		public function getItemAt(index:uint):Object {
			return _dataProvider[index];
		}
		
		public function getLength():uint {
			return _dataProvider.length;
		}
		
		public function removeItem(item:Object):Object {
			var _6:int = _dataProvider.indexOf(item);
			if (_6 == -1) {
				return null;
			}
			return removeItemAt(_6);
		}
		
		public function removeItemAt(index:uint):Object {
			var _6:Object = _dataProvider[index];
			_dataProvider.splice(index,1);
			var _7:DisplayObject = _cellRenderers[index];
			_7.removeEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown);
			_7.removeEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
			_7.removeEventListener(MouseEvent.ROLL_OVER,onItemOver);
			content.removeChild(_7);
			_cellRenderers.splice(index,1);
			for (var _8:int = index,_9:uint = _cellRenderers.length; _8 < _9; _8++){
				_cellRenderers[_8].setIndex(_8);
			}
			for (_8 = _selectedIndices.length; _8 >= 0; _8--) {
				if (_selectedIndices[_8] == index) {
					_selectedIndices.splice(_8,1);
				} else if (_selectedIndices[_8] > index) {
					_selectedIndices[_8] -= 1;
				}
			}
			if (_selectedIndex == index) {
				_selectedIndex = -1;
			} else if (_selectedIndex > index) {
				_selectedIndex--;
			}
			if (_lastSelectedIndex == index) {
				_lastSelectedIndex = -1;
			} else if (_lastSelectedIndex > index) {
				_lastSelectedIndex--;
			}
			if (_focusIndex == index) {
				_focusIndex = -1;
			} else if (_focusIndex > index) {
				_focusIndex--;
			}
			repaint();
			return _6;
		}
		
		public function removeAll():void {
			for (var _6:int = _cellRenderers.length - 1; _6 >= 0; _6--) {
				var _7:DisplayObject = _cellRenderers[_6];
				_7.removeEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown);
				_7.removeEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
				_7.removeEventListener(MouseEvent.ROLL_OVER,onItemOver);
				content.removeChild(_7);
			}
			_cellRenderers.splice(0);
			_dataProvider.splice(0);
			_selectedIndex = _lastSelectedIndex = _focusIndex = -1;
			_selectedIndices.splice(0);
			repaint();
		}
		
		public function replaceItemAt(item:Object,index:uint):Object {
			var _6:Object = _dataProvider[index];
			_dataProvider.splice(index,1,item);
			var _7:ICellRenderer = _cellRenderers[index];
			var _8:String = null;
			if (item != null) {
				_8 = item.hasOwnProperty("label") ? item.label : item.toString();
			}
			_7.setLabel(_8);
			_7.setData(item);
			repaint();
			return _6;
		}
		
		public function sortItems(... sortArgs):* {
			var _6:Array = _dataProvider.slice();
			var result:* = _dataProvider.sort(sortArgs);
			var _7:Array = [];
			for (var _8:int = 0,_9:uint = _6.length; _8 < _9; _8++) {
				var _10:int = _dataProvider.indexOf(_6[_8]);
				while (_7.indexOf(_10) != -1) {
					_10 = _dataProvider.indexOf(_6[_8],_10 + 1);
				}
				_7[_8] = _10;
			}
			_6 = _cellRenderers.slice();
			for (_8 = 0,_9 = _6.length; _8 < _9; _8++) {
				var _11:ICellRenderer = _6[_8];
				_10 = _7[_8];
				_11.setIndex(_10);
				content.swapChildren(DisplayObject(_11),_cellRenderers[_10]);
				_cellRenderers[_10] = _11;
			}
			for (_8 = 0,_9 = _selectedIndices.length; _8 < _9; _8++) {
				_selectedIndices[_8] = _7[_selectedIndices[_8]];
			}
			if (_selectedIndex != -1) {
				_selectedIndex = _7[_selectedIndex];
			}
			if (_lastSelectedIndex != -1) {
				_lastSelectedIndex = _7[_lastSelectedIndex];
			}
			if (_focusIndex != -1) {
				_focusIndex = _7[_focusIndex];
			}
			repaint();
			return result;
		}
		
		
		public function sortItemsOn(field:String,options:Object=null):* {
			var _6:Array = _dataProvider.slice();
			var result:* = _dataProvider.sortOn(field,options);
			var _7:Array = [];
			for (var _8:int = 0,_9:uint = _6.length; _8 < _9; _8++) {
				var _10:int = _dataProvider.indexOf(_6[_8]);
				while (_7.indexOf(_10) != -1) {
					_10 = _dataProvider.indexOf(_6[_8],_10 + 1);
				}
				_7[_8] = _10;
			}
			_6 = _cellRenderers.slice();
			for (_8 = 0,_9 = _6.length; _8 < _9; _8++) {
				var _11:ICellRenderer = _6[_8];
				_10 = _7[_8];
				_11.setIndex(_10);
				content.swapChildren(DisplayObject(_11),_cellRenderers[_10]);
				_cellRenderers[_10] = _11;
			}
			for (_8 = 0,_9 = _selectedIndices.length; _8 < _9; _8++) {
				_selectedIndices[_8] = _7[_selectedIndices[_8]];
			}
			if (_selectedIndex != -1) {
				_selectedIndex = _7[_selectedIndex];
			}
			if (_lastSelectedIndex != -1) {
				_lastSelectedIndex = _7[_lastSelectedIndex];
			}
			if (_focusIndex != -1) {
				_focusIndex = _7[_focusIndex];
			}
			repaint();
			return result;
		}
		
		public function isItemSelected(item:Object):Boolean {
			var _6:int = _dataProvider.indexOf(item);
			if (_6 == -1) {
				return false;
			}
			return _selectedIndices.indexOf(_6) != -1;
		}
		
		public function setSelectedIndex(index:int):void {
			if (! getSelectable()) {
				return;
			}
			if (getMultipleSelection()) {
				setSelectedIndices([index]);
				return;
			}
			if (_selectedIndex == index) {
				return;
			}
			if (_selectedIndex != -1) {
				_cellRenderers[_selectedIndex].setSelected(false);
			}
			_selectedIndex = _lastSelectedIndex = index;
			if (_selectedIndex != -1) {
				_focusIndex = index;
				_cellRenderers[index].setSelected(true);
				scrollToIndex(index);
			}
		}
		
		public function getSelectedIndex():int {
			return _selectedIndex;
		}
		
		public function setSelectedItem(item:Object):void {
			if (! getSelectable()) {
				return;
			}
			var _6:int = _dataProvider.indexOf(item);
			if (_6 == -1) {
				return;
			}
			setSelectedIndex(_6);
		}
		
		public function getSelectedItem():Object {
			if (_selectedIndex == -1) {
				return null;
			}
			return _dataProvider[_selectedIndex];
		}
		
		public function setSelectedIndices(indices:Array):void {
			if (! getSelectable() || ! getMultipleSelection()) {
				return;
			}
			if ((indices == null && _selectedIndices.length == 0) || (indices.toString() == _selectedIndices.toString())) {
				return;
			}
			for (var _6:int = 0,_7:uint = _selectedIndices.length; _6 < _7; _6++) {
				var _8:int = _selectedIndices[_6];
				if (indices == null || indices.indexOf(_8) == -1) {
					_cellRenderers[_8].setSelected(false);
				}
			}
			_selectedIndex = _lastSelectedIndex = -1;
			_selectedIndices.splice(0);
			if (indices != null && indices.length > 0) {
				for (_6 = 0,_7 = indices.length; _6 < _7; _6++) {
					_8 = indices[_6];
					if (_8 >= 0 && _8 < getLength() && _selectedIndices.indexOf(_8) == -1) {
						_selectedIndex = _lastSelectedIndex = _8;
						_selectedIndices.push(_8);
						_focusIndex = _8;
						var _9:ICellRenderer = _cellRenderers[_8];
						if (! _9.getSelected()) {
							_9.setSelected(true);
						}
					}
				}
				scrollToIndex(_selectedIndex);
			}
		}
		
		public function getSelectedIndices():Array {
			if (! getMultipleSelection()) {
				return _selectedIndex != -1 ? [_selectedIndex]:[];
			}
			return _selectedIndices.slice();
		}
		
		public function setSelectedItems(items:Array):void {
			if (! getSelectable() || ! getMultipleSelection()) {
				return;
			}
			var _6:Array = [];
			if (items != null) {
				for (var _7:int = 0,_8:uint = items.length; _7 < _8; _7++) {
					var _9:int = _dataProvider.indexOf(items[_7]);
					while (_6.indexOf(_9) != -1) {
						_9 = _dataProvider.indexOf(items[_7],_9 + 1);
					}
					if (_9 != -1) {
						_6.push(_9);
					}
				}
			}
			setSelectedIndices(_6);
		}
		
		public function getSelectedItems():Array {
			if (! getMultipleSelection()) {
				return _selectedIndex != -1 ? [_dataProvider[_selectedIndex]]:[];
			}
			var _6:Array = [];
			for (var _7:int = 0,_8:uint = _selectedIndices.length; _7 < _8; _7++) {
				_6.push(_dataProvider[_selectedIndices[_7]]);
			}
			return _6;
		}
		
		public function clearSelection():void {
			
			!getMultipleSelection() ? setSelectedIndex(-1) : setSelectedIndices([]);
		}
		
		
		
		
		public function scrollToIndex(index:int):void {
			if (index < 0 || index >= getLength()) {
				return;
			}
			var _6:Rectangle = content.scrollRect;
			if (_6 == null) {
				return;
			}
			var _7:Number = _6.y;
			var _8:DisplayObject = _cellRenderers[index];
			var _9:Number = _8.y;
			if (_7 > _9) {
				setVerticalScrollPosition(_9);
			} else if (_7 < _9) {
				_9 = _9 + _8.height - _6.height;
				if (_7 < _9) {
					setVerticalScrollPosition(_9);
				}
			}
		}
		
		public function scrollToSelected():void {
			scrollToIndex(Math.max(0,_selectedIndex));
		}
		
		public function setRowHeight(height:Number):void {
			_3 = height;
			_4 = true;
			repaint();
		}
		
		public function getRowHeight():Number {
			return _3;
		}
		
		public function setVisibleRowCount(rowCount:uint):void {
			setRowCount(rowCount);
		}
		
		public function getVisibleRowCount():uint {
			return getRowCount();
		}
		
		public function setRowCount(rowCount:uint):void {
			var _6:Number = content.y + _3 * rowCount;
			if (! horizontalScrollBar.visible) {
				_6 +=  content.y;
			} else {
				_6 +=  horizontalScrollBar.height + horizontalScrollBar.x;
			}
			height = _6;
		}
		
		public function getRowCount():uint {
			var _6:Number = height - content.y;
			if (! horizontalScrollBar.visible) {
				_6 -=  content.y;
			} else {
				_6 -=  horizontalScrollBar.height - horizontalScrollBar.x;
			}
			return Math.ceil(_6 / _3);
		}
		
		public function setDragEnabled(dragEnabled:Boolean):void{
			_5 = dragEnabled;
		}
		
		public function getDragEnabled():Boolean{
			return _5;
		}
		protected function createCellRenderer(value:Object,index:uint):ICellRenderer {
			var _6:ICellRenderer = new _cellRenderer();
			_6.setOwner(this);
			_6.setIndex(index);
			var _7:String = null;
			if (value != null) {
				_7 = value.hasOwnProperty("label") ? value.label : value.toString();
				if(value.hasOwnProperty("icon") && (value.icon is DisplayObject)){
					_6.setIcon(DisplayObject(value.icon));
				}
			}
			_6.setData(value);
			_6.setLabel(_7);
			return _6;
		}
		
		public function itemToCellRenderer(item:Object):ICellRenderer {
			var _6:int = _dataProvider.indexOf(item);
			if (_6 == -1) {
				return null;
			}
			return _cellRenderers[_6];
		}
		protected function onBeforeItemDown(evt:MouseEvent):void{
						if(! getSelectable()){
				var _6:int = _cellRenderers.indexOf(evt.currentTarget);
				scrollToIndex(_6);
				evt.stopImmediatePropagation();
			}
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		protected function onItemDown(evt:MouseEvent):void {
			if (! getSelectable()) {
				return;
			}
			if(! _mousePressed){
				_mousePressed = true;
				stage.addEventListener(MouseEvent.MOUSE_UP,onItemUp,false,0,true);
			}
			var _6:ICellRenderer = ICellRenderer(evt.currentTarget);
			var _7:int = _cellRenderers.indexOf(_6);
			if (! _6.getSelected() && (! getMultipleSelection() || ! evt.ctrlKey)){
				_6.setSelected(true);
			}
			if (! getMultipleSelection()) {
				if (_selectedIndex == _7){
					return;
				}
				setSelectedIndex(_7);
			} else if (evt.ctrlKey) {
				var _8:Array = getSelectedIndices();
				if (_6.getSelected()) {
					_8.push(_7);
				} else {
					_8.splice(_8.indexOf(_7),1);
				}
				setSelectedIndices(_8);
				_focusIndex = _lastSelectedIndex = _7;
			} else if (evt.shiftKey && _lastSelectedIndex != -1) {
				_8 = [];
				var _9:int = _lastSelectedIndex < _7 ? 1:-1;
				for (var _10:int = _lastSelectedIndex; _10 != _7; _10 += _9) {
					_8.push(_10);
				}
				_8.push(_7);
				if (_8.toString() == _selectedIndices.toString()) {
					return;
				}
				_7 = _lastSelectedIndex;
				setSelectedIndices(_8);
				_lastSelectedIndex = _7;
			} else {
				if (_selectedIndices.length == 1 && _selectedIndices[0] == _7) {
					return;
				}
				setSelectedIndices([_7]);
			}
					}
		protected function onItemUp(evt:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP,onItemUp);
			_mousePressed = false;
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected function onItemOver(evt:MouseEvent):void {
			if (!_mousePressed || getDragEnabled()) {
				return;
			}
			var _6:DisplayObject = DisplayObject(evt.currentTarget);
			_6.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,false,evt.localX,evt.localY,evt.relatedObject,evt.ctrlKey,evt.altKey,evt.shiftKey,evt.buttonDown));
		}
		protected override function onKeyDown(evt:KeyboardEvent):void {
						var _6:uint = getLength();
			if (_6 == 0) {
				return;
			}
			if (evt.keyCode == Keyboard.LEFT || evt.keyCode == Keyboard.RIGHT) {
				if (! horizontalScrollBar.getEnabled()) {
					return;
				}
				var _7:Number = horizontalScrollBar.getScrollPosition();
				var _8:Number = horizontalScrollBar.getLineScrollSize();
				if (evt.keyCode == Keyboard.LEFT) {
					if (_7 > horizontalScrollBar.getMinScrollPosition()) {
						horizontalScrollBar.setScrollPosition(_7 - _8);
					}
				} else if (evt.keyCode == Keyboard.RIGHT) {
					if (_7 < horizontalScrollBar.getMaxScrollPosition()) {
						horizontalScrollBar.setScrollPosition(_7 + _8);
					}
				}
				return;
			}
			var _9:int = -1;
			var _10:Rectangle = content.scrollRect;
			switch (evt.keyCode) {
				case Keyboard.HOME :
					_9 = 0;
					break;
				case Keyboard.END :
					_9 = _6 - 1;
					break;
				case Keyboard.UP :
					_9 = Math.max(0,_focusIndex - 1);
					break;
				case Keyboard.DOWN :
					_9 = Math.min(_6 - 1,_focusIndex + 1);
					break;
				case Keyboard.PAGE_UP :
					if (_6 == 1 || _10 == null || _focusIndex < 1) {
						_9 = 0;
					} else {
						var _11:DisplayObject = _cellRenderers[_focusIndex];
						var _12:Number = _11.height;
						_9 = _focusIndex - 1;
						_12 +=  _cellRenderers[_9].height;
						while (_12 <= _10.height && _9 > 0) {
							_11 = _cellRenderers[_9 - 1];
							_12 +=  _11.height;
							if (_12 <= _10.height) {
								_9--;
							}
						}
					}
					break;
				case Keyboard.PAGE_DOWN :
					if (_6 == 1 || _10 == null || _focusIndex == _6 - 1) {
						_9 = _6 - 1;
					} else {
						_9 = Math.max(0,_focusIndex);
						_11 = _cellRenderers[_9];
						setVerticalScrollPosition(_11.y);
						_12 = _11.height;
						_9++;
						_12 +=  _cellRenderers[_9].height;
						while (_12 <= _10.height && _9 + 1 < _6) {
							_11 = _cellRenderers[_9 + 1];
							_12 +=  _11.height;
							if (_12 <= _10.height) {
								_9++;
							}
						}
					}
					break;
				default :
					var _13:String = String.fromCharCode(evt.charCode).toUpperCase(),_14:Stirng;
					var _15:uint = _focusIndex;
					while (true) {
						_15++;
						if (_15 == _6) {
							if (_focusIndex == -1) {
								break;
							}
							_15 = 0;
						}
						_14 = _cellRenderers[_15].getLabel();
						if (_14 != null && _14.toUpperCase().indexOf(_13) == 0) {
							_9 = _15;
							break;
						}
						if (_15 == _focusIndex) {
							break;
						}
					}
			}
			if (_9 == -1) {
				return;
			}
			if (! getSelectable()) {
				scrollToIndex(_9);
				return;
			}
			if (! getMultipleSelection()) {
				if (_selectedIndex == _9){
					return;
				}
				setSelectedIndex(_9);
			} else if (evt.shiftKey && _lastSelectedIndex != -1) {
				var _16:Array = [];
				var _17:int = _lastSelectedIndex < _9 ? 1:-1;
				for (var _18:int = _lastSelectedIndex; _18 != _9; _18 += _17) {
					_16.push(_18);
				}
				_16.push(_9);
				if (_16.toString() == _selectedIndices.toString()) {
					return;
				}
				_9 = _lastSelectedIndex;
				setSelectedIndices(_16);
				_lastSelectedIndex = _9;
			} else {
				if (_selectedIndices.length == 1 && _selectedIndices[0] == _9) {
					return;
				}
				setSelectedIndices([_9]);
			}
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		public override function repaint():void {
						var _6:Number = _width;
			var _7:Number = _height;
			var _8:String = getHorizontalScrollPolicy();
			var _9:String = getVerticalScrollPolicy();
			var _10:Number = _6 - _contentPaddingX * 2;
			var _11:Number = _7 - _contentPaddingY * 2;
			var _12:Number = _10 - verticalScrollBar.width;
			var _13:Number = _11 - horizontalScrollBar.height;
			var _14:Rectangle = new Rectangle(0,0,_8 == "on" ? _12:_10,_9 == "on" ? _13:_11);
			var _15:Number = 0,_16:Number = 0;
			for (var _17:int = 0,_18:uint = _cellRenderers.length; _17 < _18; _17++) {
				var _19:DisplayObject = _cellRenderers[_17];
				_19.y = _15;
				ICellRenderer(_19).setSize(_14.width,_3);
				_15 +=  _19.height;
				_16 = Math.max(_16,_19.width);
				if (_8 == "auto" && _14.height == _11 && _16 > _14.width) {
					_14.height = _13;
				}
				if (_9 == "auto" && _14.width == _10 && _15 > _14.height) {
					_14.width = _12;
					_15 = _16 = 0;
					_17 = -1;
				}
			}
			content.setSize(_16,_15);
			super.repaint();
			if (verticalScrollBar.getEnabled()) {
				if (_vPageScrollSize <= 0) {
					verticalScrollBar.setPageScrollSize(Math.max(0,_14.height - _3));
				}
				if (_vLineScrollSize <= 0) {
					verticalScrollBar.setLineScrollSize(_3);
				}
			}
			if (focusRectSkin != null) {
				focusRectSkin.width = _6;
				focusRectSkin.height = _7;
			}
		}
	}
}

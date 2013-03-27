package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import shinater.swing.managers.FocusManager;
	import shinater.swing.managers.CursorManager;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class DataGrid extends List {
		
		public const AUTO_RESIZE_LAST_COLUMN:String = "lastColumn";
		
		public const AUTO_RESIZE_NEXT_COLUMN:String = "nextColumn";
		
		public const AUTO_RESIZE_OFF:String = "off";
		
		public const AUTO_RESIZE_SUBSEQUENT_COLUMNS:String = "subsequentColumns";
		private var _1:String = AUTO_RESIZE_SUBSEQUENT_COLUMNS;
		private var _2:Number = -1;
		private var _3:Boolean = true;
		private var _4:Array = [];
		private var _5:Array = [];
		private var _6:Array = [];
		private var _7:Array = [];
		private var _8:Array = [];
		private var _9:Array = [];
		private var _10:Array = [];
		private var _11:Array = [];
		private var _12:Array = [];
		private var _13:Array = [];
		private var _14:Array = [];
		private var _15:Array = [];
		private var _16:Boolean = false;
		private var _17:Boolean = false;
		private var _18:Boolean = true;
		private var _19:Boolean = true;
		private var _20:int = -1;
		private var _21:Boolean = false;
		private var _22:Boolean = true;
		private var _23:DisplayObjectContainer;
		private var _24:DisplayObjectContainer;
		private var _25:DisplayObjectContainer;
		private var _26:DisplayObjectContainer;
		
		private var _27:ToggleButton;
		private var _28:Number;
		private var _29:int = -1;
		private var _30:DisplayObject;
		private var _31:DisplayObject;
		
		public var horizontalLineSkin:Sprite;
		
		public var verticalLineSkin:Sprite;
		
		public var header:ToggleButton;
		
		public var headerSortArrowAscSkin:Sprite;
		
		public var headerSortArrowDescSkin:Sprite;
		
		public function DataGrid() {
			super();
		}
		protected override function init():void {
			if(horizontalLineSkin != null){
				removeChild(horizontalLineSkin);
			}
			if(verticalLineSkin != null){
				removeChild(verticalLineSkin);
			}
			_24 = new Sprite();
			content.addChild(_24);
			_26 = new Sprite();
			content.addChild(_26);
			_23 = new Sprite();
			_26.addChild(_23);
			_2 = header.height;
			header.setLabelPlacement(Button.LABELPLACEMENT_LEFT);
			header.setFocusEnabled(false);
			removeChild(header);
			if(headerSortArrowAscSkin != null){
				removeChild(headerSortArrowAscSkin);
			}
			if(headerSortArrowDescSkin != null){
				removeChild(headerSortArrowDescSkin);
			}
			_25 = new Sprite();
			content.addChild(_25);
			super.init();
			setCellRenderer(null);
			setResizableColumns(true);
		}
		
		
		public override function setCellRenderer(cellRenderer:Class):void {
			if(cellRenderer != null){
				super.setCellRenderer(cellRenderer);
			}
			_cellRenderer = cellRenderer;
			setDataProvider(_dataProvider.slice());
		}
		
		public override function setHorizontalScrollPolicy(policy:String):void {
			_1 = policy == "off" ? AUTO_RESIZE_SUBSEQUENT_COLUMNS : AUTO_RESIZE_OFF;
			autoResizeColumns();
			super.setHorizontalScrollPolicy(policy);
		}
		
		public function setAutoResizeMode(mode:String):void{
			_1 = mode;
			autoResizeColumns();
			repaint();
		}
		
		public function getAutoResizeMode():String{
			return _1;
		}
		private function autoResizeColumns(columnIndex:int = -1, width:Number = undefined):void{
						var _32:uint = getColumnCount();
			if(_32 == 0){
				return;
			}
			if(_1 == AUTO_RESIZE_OFF){
				if(columnIndex != -1){
					_11[columnIndex] = width;
				}
				return;
			}
			if(columnIndex == -1 || _1 == AUTO_RESIZE_SUBSEQUENT_COLUMNS){
				var _33:uint = _11.length;
				var _34:Number = 0, _35:Number = 0;
				for(var _36:int = columnIndex+1; _36<_33; _36++){
					_34 += _11[_36];
					_35 += _12[_36];
				}
				var _37:Number;
				if(columnIndex == -1){
					_37 = _width - _contentPaddingX*2;
					if(verticalScrollBar.visible){
						_37 -= verticalScrollBar.width;
					}
				}else{
					_37 = _34 - (width - _11[columnIndex]);
					_11[columnIndex] = width;
				}
				for(_36 = columnIndex+1; _36<_33; _36++){
					if(_36 == _33-1){
						_11[_36] = _37;
					}else{
						width = _11[_36];
						var _38:Number = _12[_36];
						_35 -= _38;
						_11[_36] = Math.max(_38, Math.min(_37-_35, Math.round(_37*width/_34)));
						_34 -= width;
						_37 -= _11[_36];
					}
				}
				return;
			}
			var _39:int = _1 == AUTO_RESIZE_NEXT_COLUMN ? columnIndex+1 : _32-1;
			if(_39 == columnIndex || _39 >= _32){
				return;
			}
			_11[_39] -= width - _11[columnIndex];
			_11[columnIndex] = width;
		}
		
		public function setEditable(editable:Boolean):void{
			if(_16 == editable){
				return;
			}
			_16 = editable;
			if(editable){
				addEventListener(FocusEvent.KEY_FOCUS_CHANGE,onKeyFocusChange,false,0,true);
			}else{
				removeEventListener(FocusEvent.KEY_FOCUS_CHANGE,onKeyFocusChange);
			}
						if(_cellRenderer == null){
				var _32:uint = getLength();
				for(var _33:int = 0,_34:uint = getColumnCount(); _33<_34; _33++){
					if(!getColumnEditable(_33)){
						continue;
					}
					for(var _35:int = 0; _35<_32; _35++){
						_cellRenderers[_35*_34 + _33].setEditable(editable);
					}
				}
			}
		}
		
		public function getEditable():Boolean {
			return _16;
		}
		
		public function setResizableColumns(resizableColumns:Boolean):void{
			if(_17 == resizableColumns){
				return;
			}
			_17 = resizableColumns;
			if(resizableColumns){
				_25.addEventListener(MouseEvent.MOUSE_MOVE,onColumnHeaderOver,false,0,true);
				_25.addEventListener(MouseEvent.ROLL_OUT,onColumnHeaderOut,false,0,true);
			}else{
				_25.removeEventListener(MouseEvent.MOUSE_MOVE, onColumnHeaderOver);
				_25.removeEventListener(MouseEvent.ROLL_OUT, onColumnHeaderOut);
			}
		}
		
		public function getResizableColumns():Boolean {
			return _17;
		}
		
		public function setResizeColumnInRealTime(flag:Boolean):void{
			_18 = flag;
		}
		
		public function getResizeColumnInRealTime():Boolean{
			return _18;
		}
		
		public function setSortableColumns(sortableColumns:Boolean):void{
			_19 = sortableColumns;
		}
		
		public function getSortableColumns():Boolean {
			return _19;
		}
		
		public function getColumnName(columnIndex:uint):String{
			return _4[columnIndex];
		}
		
		public function getColumnIndex(columnName:String):int{
			return _4.indexOf(columnName);
		}
		
		public function setColumnCellRenderer(columnIndex:uint,cellRenderer:Class):void{
			if(columnIndex >= _7.length){
				return;
			}
			var _32:DisplayObject = DisplayObject(IDataGridCellRenderer(new cellRenderer()));
			_7[columnIndex] = cellRenderer;
		}
		
		public function getColumnCellRenderer(columnIndex:uint):Boolean{
			return _7[columnIndex];
		}
		
		public function setColumnEditable(columnIndex:uint,editable:Boolean):void{
			if(columnIndex >= _8.length){
				return;
			}
			_8[columnIndex] = editable;
			if(_cellRenderer == null && getEditable()){
				var _32:uint = getColumnCount();
				for(var _33:int = 0,_34:uint = getLength(); _33<_34; _33++){
					_cellRenderers[_33*_32 + columnIndex].setEditable(editable);
				}
			}
		}
		
		public function getColumnEditable(columnIndex:uint):Boolean{
			return _8[columnIndex];
		}
		
		public function setColumnResizable(columnIndex:uint,resizable:Boolean):void{
			if(columnIndex >= _9.length){
				return;
			}
			_9[columnIndex] = resizable;
		}
		
		public function getColumnResizable(columnIndex:uint):Boolean{
			return _9[columnIndex];
		}
		
		public function setColumnSortable(columnIndex:uint,sortable:Boolean):void{
			if(columnIndex >= _10.length){
				return;
			}
			_10[columnIndex] = sortable;
		}
		
		public function getColumnSortable(columnIndex:uint):Boolean{
			return _10[columnIndex];
		}
		
		public function setColumnSortCompareFunction(columnIndex:uint,compareFunction:Function):void{
			if(columnIndex >= _13.length){
				return;
			}
			_13[columnIndex] = compareFunction;
		}
		
		public function getColumnSortCompareFunction(columnIndex:uint):Function{
			return _13[columnIndex];
		}
		
		public function setColumnSortOptions(columnIndex:uint,sortOptions:uint):void{
			if(columnIndex >= _15.length){
				return;
			}
			_15[columnIndex] = sortOptions;
		}
		
		public function getColumnSortOptions(columnIndex:uint):uint{
			return _15[columnIndex];
		}
		private function setColumnSortDescending(columnIndex:uint,sortDescending:Boolean):void{
			if(columnIndex >= _14.length){
				return;
			}
			_14[columnIndex] = sortDescending;
		}
		private function getColumnSortDescending(columnIndex:uint):Boolean{
			return _14[columnIndex];
		}
		
		public function setColumnMinWidth(columnIndex:uint,minWidth:Number):void{
			if(columnIndex >= _12.length){
				return;
			}
			_12[columnIndex] = minWidth;
			if(_11[columnIndex] < minWidth){
				autoResizeColumns(columnIndex, minWidth);
				repaint();
			}
		}
		
		public function getColumnMinWidth(columnIndex:uint):Number{
			return _12[columnIndex];
		}
		
		public function setColumnWidth(columnIndex:uint,width:Number):void{
			if(columnIndex >= _11.length || _11[columnIndex] == width){
				return;
			}
			autoResizeColumns(columnIndex, width);
			repaint();
		}
		
		public function getColumnWidth(columnIndex:uint):Number{
			return _11[columnIndex];
		}
		
		public function getColumnCount():uint{
			return _4.length;
		}
		
		public function addColumn(columnName:String,columnTitle:String = null):void{
			addColumnAt(columnName,getColumnCount(),columnTitle);
		}
		
		public function addColumnAt(columnName:String,columnIndex:uint,columnTitle:String = null):void{
			columnTitle = columnTitle || columnName;
			_4.splice(columnIndex,0,columnName);
			_5.splice(columnIndex,0,columnTitle);
			var _32:ToggleButton;
			if (columnIndex == 0) {
				_32 = header;
				if (_6.length > 0 && _6[0] == header) {
					var _33:ToggleButton = createColumnHeader(header.getLabel());
					_33.setIcon(header.getIcon());
					_33.setSelected(header.getSelected());
					_33.addEventListener(MouseEvent.CLICK,onColumnHeaderClick,false,0,true);
					_33.addEventListener(MouseEvent.MOUSE_DOWN,onColumnHeaderDown,false,1,true);
					_25.addChildAt(_33, _25.getChildIndex(header) + 1);
					_6[0] = _33;
				}else{
					_32.addEventListener(MouseEvent.CLICK,onColumnHeaderClick,false,0,true);
					_32.addEventListener(MouseEvent.MOUSE_DOWN,onColumnHeaderDown,false,1,true);
					_25.addChildAt(_32,_6.length > 0 ? _25.getChildIndex(_6[0]) : _25.numChildren);
				}
				_32.setLabel(columnTitle);
				_32.setIcon(null);
				_32.setSelected(false);
			} else {
				_32 = createColumnHeader(columnTitle);
				_32.addEventListener(MouseEvent.CLICK,onColumnHeaderClick,false,0,true);
				_32.addEventListener(MouseEvent.MOUSE_DOWN,onColumnHeaderDown,false,1,true);
				var _34:uint = columnIndex < _6.length ? _25.getChildIndex(_6[columnIndex]) : _25.numChildren;
				_25.addChildAt(_32,_34);
			}
			_6.splice(columnIndex,0,_32);
			_7.splice(columnIndex,0,DataGridCellRenderer);
			_8.splice(columnIndex,0,true);
			var _35:uint = getLength();
			if(_35 > 0){
				var _36:Array = getSelectedIndices();
				var _37:uint = _4.length;
				if(_cellRenderer != null){
					if(_37 == 1){
						for(var _38:int = 0; _38<_35; _38++){
							var _39:Object = getItemAt(_38);
							var _40:ICellRenderer = createCellRenderer(_39,_38);
							if(_36.indexOf(_38) != -1){
								_40.setSelected(true);
							}
							var _41:DisplayObject = DisplayObject(_40);
							_41.addEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown,false,1,true);
							_41.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown,false,0,true);
							_41.addEventListener(MouseEvent.ROLL_OVER,onItemOver,false,0,true);
							_41.addEventListener(KeyboardEvent.KEY_DOWN,onItemKeyDown,false,0,true);
							_41.addEventListener(FocusEvent.FOCUS_IN,onItemFocusIn,false,0,true);
							_41.addEventListener(FocusEvent.FOCUS_OUT,onItemFocusOut,false,0,true);
							_26.addChild(_41);
							_cellRenderers.push(_40);
						}
					}
				}else{
					for(_38 = 0; _38<_35; _38++){
						for(var _42:int = 0; _42<_37; _42++){
							var _43:int = _38*_37 + _42;
							var _44:IDataGridCellRenderer;
							if(_42 == columnIndex){
								_39 = getItemAt(_38);
								_44 = createDataGridCellRenderer(_39,_38,_42);
								if(_36.indexOf(_38) != -1){
									_44.setSelected(true);
								}
								_41 = DisplayObject(_40);
								_41.addEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown,false,1,true);
								_41.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown,false,0,true);
								_41.addEventListener(MouseEvent.ROLL_OVER,onItemOver,false,0,true);
								_41.addEventListener(KeyboardEvent.KEY_DOWN,onItemKeyDown,false,0,true);
								_41.addEventListener(FocusEvent.FOCUS_IN,onItemFocusIn,false,0,true);
								_41.addEventListener(FocusEvent.FOCUS_OUT,onItemFocusOut,false,0,true);
								_34 = _cellRenderers.length > 0  && _34 < _cellRenderers.length ? _26.getChildIndex(_cellRenderers[_43]) : _26.numChildren;
								_26.addChildAt(_41,_34);
								_cellRenderers.splice(_43,0,_44);
							}else{
								_44 = _cellRenderers[_43];
								_44.setIndex(_43);
																_44.setColumn(_42);
							}
						}
					}
					if(_focusIndex != -1){
						_37--;
						var _45:int = int(_focusIndex/_37);
						var _46:int = _focusIndex%_37
						_focusIndex += _45;
						if(_46 >= columnIndex){
							_focusIndex++;
						}
					}
				}
			}
			_9.splice(columnIndex,0,true);
			_10.splice(columnIndex,0,true);
			_11.splice(columnIndex,0,0);
			_12.splice(columnIndex,0,20);
			autoResizeColumns(columnIndex, 100);
			_13.splice(columnIndex,0,null);
			_15.splice(columnIndex,0,null);
			_14.splice(columnIndex,0,undefined);
			if(_20 >= columnIndex){
				_20++;
			}
			repaint();
		}
		
		public function removeColumnAt(columnIndex:uint):String{
			var _32:String = _4[columnIndex];
			var _33:ToggleButton = _6[columnIndex];
			_33.removeEventListener(MouseEvent.CLICK, onColumnHeaderClick);
			_33.removeEventListener(MouseEvent.MOUSE_DOWN, onColumnHeaderDown);
			_25.removeChild(_33);
			_6.splice(columnIndex,1);
			var _34:uint = getLength();
			if(_34 > 0){
				var _35:uint = _4.length;
				if(_cellRenderer != null){
					if(_35 == 1){
						for(var _36:int = 0; _36<_34; _36++){
							var _37:DisplayObject = _cellRenderers[_38];
							_37.removeEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown);
							_37.removeEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
							_37.removeEventListener(MouseEvent.ROLL_OVER,onItemOver);
							_37.removeEventListener(KeyboardEvent.KEY_DOWN,onItemKeyDown);
							_37.removeEventListener(FocusEvent.FOCUS_IN,onItemFocusIn);
							_37.removeEventListener(FocusEvent.FOCUS_OUT,onItemFocusOut);
							_26.removeChild(_37);
						}
						_cellRenderers.splice(0);
						_selectedIndex = _lastSelectedIndex = _focusIndex = -1;
						_selectedIndices.splice(0);
					}
				}else{
					var _38:int = 0;
					for(_36 = 0; _36<_34; _36++){
						for(var _39:int = 0; _39<_35; _39++){
							var _40:IDataGridCellRenderer;
							if(_39 == columnIndex){
								_37 = _cellRenderers[_38];
								_37.removeEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown);
								_37.removeEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
								_37.removeEventListener(MouseEvent.ROLL_OVER,onItemOver);
								_37.removeEventListener(KeyboardEvent.KEY_DOWN,onItemKeyDown);
								_37.removeEventListener(FocusEvent.FOCUS_IN,onItemFocusIn);
								_37.removeEventListener(FocusEvent.FOCUS_OUT,onItemFocusOut);
								_26.removeChild(_37);
								_cellRenderers.splice(_38,1);
							}else{
								_40 = _cellRenderers[_38];
								_40.setIndex(_38);
																_40.setColumn(_39);
								_38++;
							}
						}
					}
					if(_focusIndex != -1){
						if(_35 == 1){
							_focusIndex = _selectedIndex;
						}else{
							var _41:int = int(_focusIndex/_35);
							_focusIndex -= _41;
							if(int(_focusIndex/(_35-1)) > _41){
								_focusIndex--;
							}
						}
					}
				}
			}
			_4.splice(columnIndex,1);
			_5.splice(columnIndex,1);
			_7.splice(columnIndex,1);
			_8.splice(columnIndex,1);
			_9.splice(columnIndex,1);
			_10.splice(columnIndex,1);
			autoResizeColumns(columnIndex, 0);
			_11.splice(columnIndex,1);
			_12.splice(columnIndex,1);
			_13.splice(columnIndex,1);
			_15.splice(columnIndex,1);
			_14.splice(columnIndex,1);
			if(_20 == columnIndex){
				_20 = -1;
			}else if(_20 > columnIndex){
				_20--;
			}
			repaint();
			return _32;
		}
		
		public function removeAllColumns():void{
			for (var _32:int = _6.length - 1; _32 >= 0; _32--) {
				var _33:ToggleButton = _6[_32];
				_33.removeEventListener(MouseEvent.CLICK, onColumnHeaderClick);
				_33.removeEventListener(MouseEvent.MOUSE_DOWN, onColumnHeaderDown);
				_25.removeChild(_33);
			}
			_6.splice(0);
			for (_32 = _cellRenderers.length - 1; _32 >= 0; _32--) {
				var _34:DisplayObject = _cellRenderers[_32];
				_34.removeEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown);
				_34.removeEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
				_34.removeEventListener(MouseEvent.ROLL_OVER,onItemOver);
				_34.removeEventListener(KeyboardEvent.KEY_DOWN,onItemKeyDown);
				_34.removeEventListener(FocusEvent.FOCUS_IN,onItemFocusIn);
				_34.removeEventListener(FocusEvent.FOCUS_OUT,onItemFocusOut);
				_26.removeChild(_34);
			}
			_cellRenderers.splice(0);
			_4.splice(0);
			_5.splice(0);
			_7.splice(0);
			_8.splice(0);
			_9.splice(0);
			_10.splice(0);
			_11.splice(0);
			_12.splice(0);
			_13.splice(0);
			_15.splice(0);
			_14.splice(0);
			_20 = -1;
			_focusIndex = _selectedIndex;
			repaint();
		}
		
		public function setColumnNames(columnNames:Array):void{
			removeAllColumns();
			createColumnsFormModel(columnNames);
			setDataProvider(_dataProvider);
		}
		private function createColumnsFormModel(columnNames:Array):void{
			for (var _32:int = 0,_33:uint = columnNames.length; _32 < _33; _32++) {
				var _34:String = columnNames[_32];
				_4.push(_34);
				_5.push(_34);
				var _35:ToggleButton;
				if(_32 == 0){
					_35 = header;
					_35.setLabel(_34);
					_35.setSelected(false);
				}else{
					_35 = createColumnHeader(_34);
				}
				_35.addEventListener(MouseEvent.CLICK,onColumnHeaderClick,false,0,true);
				_35.addEventListener(MouseEvent.MOUSE_DOWN,onColumnHeaderDown,false,1,true);
				_25.addChild(_35);
				_6.push(_35);
				_7.push(DataGridCellRenderer);
				_8.push(true);
				_9.push(true);
				_10.push(true);
				_11.push(100);
				_12.push(20);
				_13.push(null);
				_15.push(null);
				_14.push(undefined);
			}
			autoResizeColumns();
		}
		private function createColumnsFromItem(item:Object):uint {
			if(item == null){
				return 0;
			}
			var _32:Array = [];
			for(var _33:String in item){
				_32.push(_33);
			}
			createColumnsFormModel(_32);
			return _32.length;
		}
		public override function setDataProvider(dataProvider:Array):void {
			removeAll();
			var _32:uint = getColumnCount();
			for (var _33:int = 0,_34:uint = dataProvider.length; _33 < _34; _33++) {
				var _35:Object = dataProvider[_33];
				_dataProvider.push(_35);
				if(_32 > 0){
					if(_cellRenderer != null){
						_32 = 1;
					}
					for(var _36:int = 0; _36<_32; _36++){
						var _37:DisplayObject = DisplayObject(_cellRenderer != null ? createCellRenderer(_35,_33) : createDataGridCellRenderer(_35,_33,_36));
						_37.addEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown,false,1,true);
						_37.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown,false,0,true);
						_37.addEventListener(MouseEvent.ROLL_OVER,onItemOver,false,0,true);
						_37.addEventListener(KeyboardEvent.KEY_DOWN,onItemKeyDown,false,0,true);
						_37.addEventListener(FocusEvent.FOCUS_IN,onItemFocusIn,false,0,true);
						_37.addEventListener(FocusEvent.FOCUS_OUT,onItemFocusOut,false,0,true);
						_26.addChild(_37);
						_cellRenderers.push(_37);
					}
				}else if(_33 == 0){
					_32 = createColumnsFromItem(_35);
				}
			}
			repaint();
		}
		public override function addItemAt(item:Object,index:uint):void {
			_dataProvider.splice(index,0,item);
			var _32:uint = _dataProvider.length;
			var _33:uint = getColumnCount();
			if(_32 == 1 && _33 == 0){
				_33 = createColumnsFromItem(item);
			}
			if(_33 > 0){
				if(_cellRenderer != null){
					_33 = 1;
				}
				var _34:int = index * _33;
				var _35:uint;
				if (_cellRenderers.length > 0 && _34 < _cellRenderers.length) {
					_35 = _26.getChildIndex(_cellRenderers[_34]);
				} else {
					_35 = _26.numChildren;
				}
				for(var _36:int = 0; _36<_33; _36++){
					var _37:DisplayObject = DisplayObject(_cellRenderer != null ? createCellRenderer(item,index) : createDataGridCellRenderer(item,index,_36));
					_37.addEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown,false,1,true);
					_37.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown,false,0,true);
					_37.addEventListener(MouseEvent.ROLL_OVER,onItemOver,false,0,true);
					_37.addEventListener(KeyboardEvent.KEY_DOWN,onItemKeyDown,false,0,true);
					_37.addEventListener(FocusEvent.FOCUS_IN,onItemFocusIn,false,0,true);
					_37.addEventListener(FocusEvent.FOCUS_OUT,onItemFocusOut,false,0,true);
					_26.addChildAt(_37,_35++);
					_cellRenderers.splice(_34++,0,_37);
				}
				for (var _38:int = index+1; _38 < _32; _38++){
					if(_cellRenderer != null){
						_cellRenderers[_38].setIndex(_38);
					}else{
						for(_36 = 0; _36<_33; _36++){
							_34 = _38*_33 + _36;
							var _39:IDataGridCellRenderer = _cellRenderers[_34];
							_39.setRow(_38);
							_39.setColumn(_36);
							_39.setIndex(_34);
						}
					}
				}
			}
			for (_38 = 0,_32 = _selectedIndices.length; _38 < _32; _38++) {
				if (_selectedIndices[_38] >= index) {
					_selectedIndices[_38] += 1;
				}
			}
			if (_selectedIndex >= index) {
				_selectedIndex++;
			}
			if (_lastSelectedIndex >= index) {
				_lastSelectedIndex++;
			}
			if (_focusIndex != -1){
				_33 = Math.max(1,_33);
				var _40:int = int(_focusIndex/_33);
				if (_40 >= index) {
					_focusIndex += _33;
				}
			}
			repaint();
		}
		public override function removeItemAt(index:uint):Object {
			var _32:Object = _dataProvider[index];
			_dataProvider.splice(index,1);
			var _33:uint = getColumnCount();
			if(_33 > 0){
				if(_cellRenderer != null){
					_33 = 1;
				}
				var _34:int = index * _33;
				for(var _35:int = 0; _35<_33; _35++){
					var _36:DisplayObject = _cellRenderers[_34];
					_36.removeEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown);
					_36.removeEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
					_36.removeEventListener(MouseEvent.ROLL_OVER,onItemOver);
					_36.removeEventListener(KeyboardEvent.KEY_DOWN,onItemKeyDown);
					_36.removeEventListener(FocusEvent.FOCUS_IN,onItemFocusIn);
					_36.removeEventListener(FocusEvent.FOCUS_OUT,onItemFocusOut);
					_26.removeChild(_36);
					_cellRenderers.splice(_34,1);
				}
				for (var _37:int = index,_38:uint = _dataProvider.length; _37 < _38; _37++){
					if(_cellRenderer != null){
						_cellRenderers[_37].setIndex(_37);
					}else{
						for(_35 = 0; _35<_33; _35++){
							_34 = _37*_33 + _35;
							var _39:IDataGridCellRenderer = _cellRenderers[_34];
							_39.setRow(_37);
							_39.setColumn(_35);
							_39.setIndex(_34);
						}
					}
				}
			}
			for (_37 = _selectedIndices.length; _37 >= 0; _37--) {
				if (_selectedIndices[_37] == index) {
					_selectedIndices.splice(_37,1);
				} else if (_selectedIndices[_37] > index) {
					_selectedIndices[_37] -= 1;
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
			if (_focusIndex != -1){
				_33 = Math.max(1,_33);
				var _40:int = int(_focusIndex/_33);
				if (_40 == index) {
					_focusIndex = -1;
				} else if (_40 > index) {
					_focusIndex -= _33;
				}
			}
			repaint();
			return _32;
		}
		public override function removeAll():void {
			for (var _32:int = _cellRenderers.length - 1; _32 >= 0; _32--) {
				var _33:DisplayObject = _cellRenderers[_32];
				_33.removeEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown);
				_33.removeEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
				_33.removeEventListener(MouseEvent.ROLL_OVER,onItemOver);
				_33.removeEventListener(KeyboardEvent.KEY_DOWN,onItemKeyDown);
				_33.removeEventListener(FocusEvent.FOCUS_IN,onItemFocusIn);
				_33.removeEventListener(FocusEvent.FOCUS_OUT,onItemFocusOut);
				_26.removeChild(_33);
			}
			_cellRenderers.splice(0);
			_dataProvider.splice(0);
			_selectedIndex = _lastSelectedIndex = _focusIndex = -1;
			_selectedIndices.splice(0);
			repaint();
		}
		public override function replaceItemAt(item:Object,index:uint):Object {
			var _32:Object = _dataProvider[index];
			_dataProvider.splice(index,1,item);
			var _33:uint = getColumnCount();
			if(_33 > 0){
				if(_cellRenderer != null){
					var _34:ICellRenderer = _cellRenderers[index];
					_34.setData(item);
				}else{
					for(var _35:int = 0; _35<_33; _35++){
						_34 = _cellRenderers[index*_33+_35];
						var columnName = getColumnName(_35);
						var _36:Object = null;
						var _37:String = null;
						if (item != null && item.hasOwnProperty(columnName)) {
							_36 = item[columnName];
							if(_36 != null){
								_37 = _36.hasOwnProperty("label") ? _36.label : _36.toString();
							}
						}
						_34.setLabel(_37);
						_34.setData(_36);
					}
				}
			}
			repaint();
			return _32;
		}
		
		public function editField(index:uint, columnName:String, data:Object):void{
			var _32:Object = getItemAt(index);
			if(_32 != null && _32.hasOwnProperty(columnName)){
				_32[columnName] = data;
			}else{
				data = null;
			}
			var _33:uint = getColumnCount();
			if(_33 == 0){
				return;
			}
			if(_cellRenderer != null){
				_cellRenderers[index].setData(_32);
			}else{
				var columnIndex = getColumnIndex(columnName);
				if(columnIndex == -1){
					return;
				}
				var _34:ICellRenderer = _cellRenderers[index*_33 + columnIndex];
				var _35:String = null;
				if(data != null){
					_35 = data.hasOwnProperty("label") ? data.label : data.toString();
				}
				_34.setLabel(_35);
				_34.setData(data);
			}
		}
		public override function sortItems(... sortArgs):* {
			var _32:Array = _dataProvider.slice();
			var result:* = _dataProvider.sort(sortArgs);
			var _33:Array = [];
			for (var _34:int = 0,_35:uint = _32.length; _34 < _35; _34++) {
				var _36:int = _dataProvider.indexOf(_32[_34]);
				while (_33.indexOf(_36) != -1) {
					_36 = _dataProvider.indexOf(_32[_34],_36 + 1);
				}
				_33[_34] = _36;
			}
			var _37:uint = getColumnCount();
			if(_37 > 0){
				if(_cellRenderer != null){
					_37 = 1;
				}
				_32 = _cellRenderers.slice();
				for(_34 = 0,_35 = _dataProvider.length; _34 < _35; _34++){
					if(_cellRenderer != null){
						var _38:ICellRenderer = _32[_34];
						_36 = _33[_34];
						_38.setIndex(_36);
						_26.swapChildren(DisplayObject(_38),_cellRenderers[_36]);
						_cellRenderers[_36] = _38;
					}else{
						for(var _39:int = 0; _39 < _37; _39++){
							var _40:int = _34*_37 + _39;
							var _41:IDataGridCellRenderer = _32[_40];
							var _42:uint = _33[_34];
							_41.setRow(_42);
							_41.setColumn(_39);
							_36 = _42*_37 + _39;
							_41.setIndex(_36);
							_26.swapChildren(DisplayObject(_41),_cellRenderers[_36]);
							_cellRenderers[_36] = _41;
						}
					}
				}
				if(_20 != -1){
					var _43:ToggleButton = _6[_20];
					_43.setIcon(null);
					_43.setSelected(false);
					_14[_20] = undefined;
					_20 = -1;
				}
			}
			for (_34 = 0,_35 = _selectedIndices.length; _34 < _35; _34++) {
				_selectedIndices[_34] = _33[_selectedIndices[_34]];
			}
			if (_selectedIndex != -1) {
				_selectedIndex = _33[_selectedIndex];
			}
			if (_lastSelectedIndex != -1) {
				_lastSelectedIndex = _33[_lastSelectedIndex];
			}
			if (_focusIndex != -1) {
				_37 = Math.max(1,_37);
				var _44:int = int(_focusIndex/_37);
				_44 = _33[_44];
				_focusIndex = _44*_37 + _focusIndex%_37;
			}
			repaint();
			return result;
		}
		public override function sortItemsOn(field:String,options:Object=null):* {
			var _32:Array = _dataProvider.slice();
			var result:* = _dataProvider.sortOn(field,options);
			var _33:Array = [];
			for (var _34:int = 0,_35:uint = _32.length; _34 < _35; _34++) {
				var _36:int = _dataProvider.indexOf(_32[_34]);
				while (_33.indexOf(_36) != -1) {
					_36 = _dataProvider.indexOf(_32[_34],_36 + 1);
				}
				_33[_34] = _36;
			}
			var _37:uint = getColumnCount();
			if(_37 > 0){
				if(_cellRenderer != null){
					_37 = 1;
				}
				_32 = _cellRenderers.slice();
				for(_34 = 0,_35 = _dataProvider.length; _34 < _35; _34++){
					if(_cellRenderer != null){
						var _38:ICellRenderer = _32[_34];
						_36 = _33[_34];
						_38.setIndex(_36);
						_26.swapChildren(DisplayObject(_38),_cellRenderers[_36]);
						_cellRenderers[_36] = _38;
					}else{
						for(var _39:int = 0; _39 < _37; _39++){
							var _40:int = _34*_37 + _39;
							var _41:IDataGridCellRenderer = _32[_40];
							var _42:uint = _33[_34];
							_41.setRow(_42);
							_41.setColumn(_39);
							_36 = _42*_37 + _39;
							_41.setIndex(_36);
							_26.swapChildren(DisplayObject(_41),_cellRenderers[_36]);
							_cellRenderers[_36] = _41;
						}
					}
				}
				var _43:int = getColumnIndex(field);
				var _44:Boolean = (options is uint) && (uint(options) & Array.DESCENDING);
				if(_43 != _20){
					if(_20 != -1){
						var _45:ToggleButton = _6[_20];
						_45.setIcon(null);
						_45.setSelected(false);
						_14[_20] = undefined;
					}
					_20 = _43;
				}
				if(_20 != -1){
					_45 = _6[_20];
					_45.setIcon(_44 ? headerSortArrowDescSkin : headerSortArrowAscSkin);
					_45.setSelected(true);
					_14[_20] = _44;
				}
			}
			for (_34 = 0,_35 = _selectedIndices.length; _34 < _35; _34++) {
				_selectedIndices[_34] = _33[_selectedIndices[_34]];
			}
			if (_selectedIndex != -1) {
				_selectedIndex = _33[_selectedIndex];
			}
			if (_lastSelectedIndex != -1) {
				_lastSelectedIndex = _33[_lastSelectedIndex];
			}
			if (_focusIndex != -1) {
				_37 = Math.max(1,_37);
				var _46:int = int(_focusIndex/_37);
				_46 = _33[_46];
				_focusIndex = _46*_37 + _focusIndex%_37;
			}
			repaint();
			return result;
		}
		public override function setSelectedIndex(index:int):void {
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
			var _32:uint = getColumnCount();
			if(_32 > 0){
				if(_cellRenderer != null){
					_32 = 1;
				}
				if(_selectedIndex != -1){
					for(var _33:int = 0; _33<_32; _33++){
						_cellRenderers[_selectedIndex*_32 + _33].setSelected(false);
					}
				}
			}
			_selectedIndex = _lastSelectedIndex = index;
			if (_selectedIndex != -1) {
				if(_32 == 0){
					_focusIndex = index;
				}else{
					_focusIndex = index * _32;
					for(_33 = 0; _33<_32; _33++){
						_cellRenderers[index*_32 + _33].setSelected(true);
					}
				}
				scrollToIndex(index);
			}
		}
		public override function setSelectedIndices(indices:Array):void {
			if (! getSelectable() || ! getMultipleSelection()) {
				return;
			}
			if ((indices == null && _selectedIndices.length == 0) || (indices.toString() == _selectedIndices.toString())) {
				return;
			}
			var _32:uint = getColumnCount();
			if(_32 > 0){
				if(_cellRenderer != null){
					_32 = 1;
				}
				for (var _33:int = 0,_34:uint = _selectedIndices.length; _33 < _34; _33++) {
					var _35:int = _selectedIndices[_33];
					if (indices == null || indices.indexOf(_35) == -1) {
						for(var _36:int = 0; _36<_32; _36++){
							_cellRenderers[_35*_32 + _36].setSelected(false);
						}
					}
				}
			}
			_selectedIndex = _lastSelectedIndex = -1;
			_selectedIndices.splice(0);
			if (indices != null && indices.length > 0) {
				for (_33 = 0,_34 = indices.length; _33 < _34; _33++) {
					_35 = indices[_33];
					if (_35 >= 0 && _35 < getLength() && _selectedIndices.indexOf(_35) == -1) {
						_selectedIndex = _lastSelectedIndex = _35;
						_selectedIndices.push(_35);
						if(_32 == 0){
							_focusIndex = _35;
						}else{
							_focusIndex = _35 * _32;
							for(_36 = 0; _36<_32; _36++){
								var _37:ICellRenderer = _cellRenderers[_35*_32 + _36];
								if (! _37.getSelected()) {
									_37.setSelected(true);
								}
							}
						}
					}
				}
				scrollToIndex(_selectedIndex);
			}
		}
		public override function scrollToIndex(index:int):void {
			if (index < 0 || index >= getLength()) {
				return;
			}
			var _32:uint = getColumnCount();
			if (_32 == 0){
				return;
			}
			if(_cellRenderer != null){
				_32 = 1;
			}
			var _33:Rectangle = _26.scrollRect;
			if (_33 == null) {
				return;
			}
			var _34:Number = _33.y;
			var _35:DisplayObject = _cellRenderers[index*_32];
			var _36:Number = _35.y;
			if (_34 > _36) {
				setVerticalScrollPosition(_36);
			} else if (_34 < _36) {
				_36 = _36 + _35.height - _33.height;
				if (_34 < _36) {
					setVerticalScrollPosition(_36);
				}
			}
		}
		protected override function onScroll(evt:Event):void {
			var _32:Rectangle = content.scrollRect;
			var _33:Rectangle = _26.scrollRect;
			if (evt.currentTarget == verticalScrollBar) {
				var _34:int = verticalScrollBar.getScrollPosition();
				_33.y = _34;
			} else if (evt.currentTarget == horizontalScrollBar) {
				var _35:int = horizontalScrollBar.getScrollPosition();
				_32.x = _35;
			}
			content.scrollRect = _32;
			_33.width = _32.x + _32.width;
			_26.scrollRect = _33;
		}
		
		public function setShowHeaders(showHeaders:Boolean):void{
			_3 = showHeaders;
			repaint();
		}
		
		public function getShowHeaders():Boolean{
			return _3;
		}
		
		public function setHeaderHeight(height:Number):void{
			_2 = height;
			repaint();
		}
		
		public function getHeaderHeight():Number{
			return _2;
		}
		
		public function setShowHorizontalLines(showHorizontalLines:Boolean):void{
			_21 = showHorizontalLines;
			repaint();
		}
		
		public function getShowHorizontalLines():Boolean{
			return _21;
		}
		
		public function setShowVerticalLines(showVerticalLines:Boolean):void{
			_22 = showVerticalLines;
			repaint();
		}
		
		public function getShowVerticalLines():Boolean{
			return _22;
		}
		public override function setVisibleRowCount(rowCount:uint):void {
			var _32:Number = content.y;
			if (getShowHeaders()){
				_32 += _2;
			}
			_32 += getRowHeight() * rowCount;
			if (getShowHorizontalLines() && horizontalLineSkin != null){
				_32 += horizontalLineSkin.height * rowCount;
			}
			if (! horizontalScrollBar.visible) {
				_32 +=  content.y;
			} else {
				_32 +=  horizontalScrollBar.height + horizontalScrollBar.x;
			}
			height = _32;
		}
		public override function getVisibleRowCount():uint {
			var _32:Number = height - content.y;
			if (! horizontalScrollBar.visible) {
				_32 -=  content.y;
			} else {
				_32 -=  horizontalScrollBar.height - horizontalScrollBar.x;
			}
			if (getShowHeaders()){
				_32 -= _2;
			}
			return Math.ceil(_32 / (getRowHeight() + (getShowHorizontalLines() && horizontalLineSkin != null ? horizontalLineSkin.height : 0)));
		}
		protected function createColumnHeader(title:String):ToggleButton{
			var _32:Class = header["constructor"] as Class;
			var _33:ToggleButton = new _32() as ToggleButton;
			_33.setLabel(title);
						_33.setLabelPlacement(Button.LABELPLACEMENT_LEFT);
			_33.setFocusEnabled(false);
			return _33;
		}
		
		[Event(name = "columnStretch",type = "flash.events.Event")]
		protected function onColumnHeaderClick(evt:MouseEvent):void{
			if (!getSortableColumns() || _29 != -1){
				return;
			}
			var _32:ToggleButton = ToggleButton(evt.currentTarget);
			var _33:int = _6.indexOf(_32);
			if (!getColumnSortable(_33)){
				return;
			}
			var _34:Boolean = _14[_33] === false;
			var _35:uint = getColumnSortOptions(_33);
			if (_34) {
				_35 |= Array.DESCENDING;
			} else {
				_35 &= ~Array.DESCENDING;
			}
			var _36:Function = getColumnSortCompareFunction(_33);
			if (_36 == null){
				sortItemsOn(getColumnName(_33),_35);
				if(_20 != _33){
					_32 = _6[_20];
					_32.setIcon(null);
					_32.setSelected(false);
					_20 = _33;
					_32 = _6[_20];
					_32.setIcon(_34 ? headerSortArrowDescSkin : headerSortArrowAscSkin);
					_32.setSelected(true);
				}
			}else{
				_14[_20] = !_34;
				sortItems(_36,_35);
				_20 = _33;
				_32 = _6[_20];
				_32.setIcon(_34 ? headerSortArrowDescSkin : headerSortArrowAscSkin);
				_32.setSelected(true);
			}
		}
		protected function onColumnHeaderOver(evt:MouseEvent):void{
			if (evt.buttonDown) {
				return;
			}
			var _32:int = -1;
			var _33:Number = this.mouseX;
			if(_33 >= 0 && _33 <= _width){
				var _34:Number = _25.mouseY;
				if(_34 >= 0 && _34 <= _25.height){
					var _35:uint = getColumnCount()
					var _36:Number = 5;
					for(var _37:int = 0; _37<_35; _37++){
						var _38:ToggleButton = _6[_37];
						_33 = _38.mouseX;
						var _39:Number = _38.width;
						if(_33 >= 0 && _33 <= _36){
							_32 = _37 - 1;
							break;
						}
						if(_33 >= _39-_36 && _33 <= _39){
							_32 = _37;
							break;
						}
					}
					if(_32 == _35-1 && _1 != AUTO_RESIZE_OFF){
						_32 = -1;
					}
				}
			}
			if(_32 != -1){
				_29 = _32;
				try{
					var _40:Class = getDefinitionByName("ColumnStretch") as Class;
					if (!(CursorManager.getCursor() is _40)) {
						CursorManager.setCursor(_40);
					}
				}catch(e:ReferenceError){
				}
			}else{
				if (CursorManager.getCursor() != null) {
					CursorManager.setCursor(null);
				}
				_29 = -1;
			}
		}
		protected function onColumnHeaderOut(evt:MouseEvent):void{
			if(!_25.mouseEnabled){
				return;
			}
			if(_29 != -1){
				CursorManager.setCursor(null);
				_29 = -1;
			}
		}
		protected function onColumnHeaderDown(evt:MouseEvent):void{
			var _32:ToggleButton = ToggleButton(evt.currentTarget);
			var _33:int = _6.indexOf(_32);
			if(getColumnResizable(_33) && _29 != -1){
				_32.mouseEnabled = false;
				_25.mouseEnabled = false;
				_27 = _32;
				_28 = mouseX;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,onColumnHeaderStretch,false,0,true);
				stage.addEventListener(MouseEvent.MOUSE_UP,onColumnHeaderUp,false,0,true);
				stage.mouseChildren = false;
				evt.stopImmediatePropagation();
				return;
			}
			if(!getSortableColumns() || !getColumnSortable(_33)){
				evt.stopImmediatePropagation();
			}
		}
		protected function onColumnHeaderUp(evt:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onColumnHeaderStretch);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onColumnHeaderUp);
			stage.mouseChildren = true;
			_25.mouseEnabled = true;
			_27.mouseEnabled = true;
			_27 = null;
			_28 = undefined;
			var _32:DisplayObject = _31;
			if(_32 != null){
				content.removeChild(_32);
				_31 = null;
				_32 = _30;
				if(_32 != null){
					_32.alpha = 1;
					_30 = null;
				}
				repaint();
			}
			onColumnHeaderOver(evt);
		}
		protected function onColumnHeaderStretch(evt:MouseEvent):void{
			var _32:int = _29;
			var _33:uint = getColumnCount();
			if(_32 == _33-1 && _1 != AUTO_RESIZE_OFF){
				return;
			}
			var _34:Number = getColumnWidth(_32);
			var _35:Number = mouseX - _28;
			if(_35 < 0){
				_35 = Math.max(getColumnMinWidth(_32)-_34,_35);
			}else if(_1 != AUTO_RESIZE_OFF){
				var _36:Number = 0;
				switch(_1){
					case AUTO_RESIZE_NEXT_COLUMN:
						_36 = getColumnWidth(_32+1) - getColumnMinWidth(_32+1);
						break;
					case AUTO_RESIZE_LAST_COLUMN:
						_36 = getColumnWidth(_33-1) - getColumnMinWidth(_33-1);
						break;
					case AUTO_RESIZE_SUBSEQUENT_COLUMNS:
						for(var _37:int = _32+1; _37<_33; _37++){
							_36 += getColumnWidth(_37) - getColumnMinWidth(_37);
						}
				}
				_35 = Math.min(_35,_36);
			}
			_35 = int(_35);
			if(_35 == 0){
				return;
			}
			_34 += _35;
			autoResizeColumns(_32,_34);
			_28 = mouseX;
			if(_18){
				repaint();
			}else{
				var _38:DisplayObject = _31;
				if(_38 == null && verticalLineSkin != null){
					if(_22){
						_38 = _30 = _32 == 0 ? verticalLineSkin : _24.getChildByName("verticalLine"+_32);
						_38.alpha = 0.5;
					}
					var _39:Class = verticalLineSkin["constructor"] as Class;
					_38 = _31 = new _39() as DisplayObject;
					var _40:Number = _height - _contentPaddingY*2;
					if(horizontalScrollBar.visible){
						_40 -= horizontalScrollBar.height;
					}
					_38.height = _40;
					content.addChild(_38);
				}
				if(_38 != null){
					_38.x = _6[_32] + getColumnWidth(_32) - _38.width;
				}
			}
			evt.updateAfterEvent();
		}
		protected override function createCellRenderer(value:Object,index:uint):ICellRenderer {
			var _32:ICellRenderer = new _cellRenderer();
			_32.setOwner(this);
			_32.setIndex(index);
			_32.setData(value);
			return _32;
		}
		protected function createDataGridCellRenderer(value:Object,row:uint,column:uint):IDataGridCellRenderer{
			var _32:IDataGridCellRenderer = new _7[column]();
			_32.setOwner(this);
			_32.setRow(row);
			_32.setColumn(column);
			_32.setIndex(getColumnCount()*row + column);
			var columnName = getColumnName(column);
			var _33:String = null;
			if (value != null) {
				value = value.hasOwnProperty(columnName) ? value[columnName] : null;
				if(value != null){
					_33 = value.hasOwnProperty("label") ? value.label : value.toString();
				}
			}
			_32.setData(value);
			_32.setLabel(_33);
			_32.setEditable(getEditable() && getColumnEditable(column));
			return _32;
		}
		
		public override function itemToCellRenderer(item:Object):ICellRenderer {
			if (_cellRenderer == null){
				return null;
			}
			var _32:int = _dataProvider.indexOf(item);
			if (_32 == -1) {
				return null;
			}
			var _33:uint = getColumnCount();
			if (_33 == 0){
				return null;
			}
			return _cellRenderers[_32];
		}
		
		public function getCellRendererAt(row:uint, column:uint):IDataGridCellRenderer {
			if (_cellRenderer != null){
				return null;
			}
			var _32:uint = getColumnCount();
			if (_32 == 0){
				return null;
			}
			return _cellRenderers[row*_32 + column];
		}
		
		public function getFocusedCellRenderer():IDataGridCellRenderer {
			if (!getEditable()){
				return null;
			}
			if (_cellRenderer != null){
				return null;
			}
			if (_focusIndex == -1){
				return null;
			}
			return _cellRenderers[_focusIndex];
		}
		protected override function onBeforeItemDown(evt:MouseEvent):void{
			if(! getSelectable()){
				var _32:int = _cellRenderers.indexOf(evt.currentTarget);
				var _33:int = _cellRenderer != null ? _32 : int(_32/getColumnCount());
				scrollToIndex(_33);
				evt.stopImmediatePropagation();
			}
		}
		protected override function onItemDown(evt:MouseEvent):void {
			if (! getSelectable()) {
				return;
			}
			if(! _mousePressed){
				_mousePressed = true;
				stage.addEventListener(MouseEvent.MOUSE_UP,onItemUp,false,0,true);
			}
			var _32:ICellRenderer = ICellRenderer(evt.currentTarget);
			var _33:int = _cellRenderers.indexOf(_32);
			var _34:int = _cellRenderer != null ? _33 : int(_33/getColumnCount());
			if (! _32.getSelected() && (! getMultipleSelection() || ! evt.ctrlKey)){
				_32.setSelected(true);
			}
			_focusIndex = _33;
			if (! getMultipleSelection()) {
				if (_selectedIndex == _34){
					return;
				}
				setSelectedIndex(_34);
			} else if (evt.ctrlKey) {
				var _35:Array = getSelectedIndices();
				if (_32.getSelected()) {
					_35.push(_34);
				} else {
					_35.splice(_35.indexOf(_34),1);
				}
				setSelectedIndices(_35);
				_lastSelectedIndex = _34;
			} else if (evt.shiftKey && _lastSelectedIndex != -1) {
				_35 = [];
				var _36:int = _lastSelectedIndex < _34 ? 1:-1;
				for (var _37:int = _lastSelectedIndex; _37 != _34; _37 += _36) {
					_35.push(_37);
				}
				_35.push(_34);
				if (_35.toString() == _selectedIndices.toString()) {
					return;
				}
				_34 = _lastSelectedIndex;
				setSelectedIndices(_35);
				_lastSelectedIndex = _34;
			} else {
				if (_selectedIndices.length == 1 && _selectedIndices[0] == _34) {
					return;
				}
				setSelectedIndices([_34]);
			}
			_focusIndex = _33;
					}
		protected override function onItemOver(evt:MouseEvent):void {
			if(getEditable()){
				return;
			}
			super.onItemOver(evt);
		}
		
		[Event(name = "cellFocusIn",type = "flash.events.Event")]
		
		[Event(name = "cellFocusOut",type = "flash.events.Event")]
		
		[Event(name = "cellEdit",type = "flash.events.Event")]
		protected function onItemFocusIn(evt:FocusEvent):void{
			if (! getEditable()) {
				return;
			}
						evt.currentTarget.dispatchEvent(new Event("cellFocusIn",true));
		}
		protected function onItemFocusOut(evt:FocusEvent):void{
			if (! getEditable()) {
				return;
			}
						var _32:ICellRenderer = ICellRenderer(evt.currentTarget);
			DisplayObject(_32).dispatchEvent(new Event("cellFocusOut",true));
			var _33:int = _cellRenderers.indexOf(_32);
			var _34:Object = _32.getData();
			var _35:int;
			var _36:Object;
			if(_cellRenderer != null){
				_35 = _33;
				_36 = getItemAt(_35);
				if(_34 == _36){
					return;
				}
				_dataProvider[_35] = _34;
			}else{
				var _37:uint = getColumnCount();
				_35 = int(_33/_37);
				_36 = getItemAt(_35);
				var _38:String = getColumnName(_33%_37);
				if(_36 != null && _36.hasOwnProperty(_38)){
					_36 = _36[_38];
				}
				if(_34 == _36){
					return;
				}
				editField(_35,_38,_34);
			}
						DisplayObject(_32).dispatchEvent(new Event("cellEdit",true));
		}
		protected function onItemKeyDown(evt:KeyboardEvent):void{
			if (! getEditable()) {
				return;
			}
			if(evt.keyCode != Keyboard.ENTER || _focusIndex == -1){
				evt.stopPropagation();
				return;
			}
			FocusManager.setFocus(this);
			var _32:int = evt.shiftKey ? -1 : 1;
			var _33:uint = getColumnCount();
			if(_cellRenderer != null){
				_33 = 1;
			}
			var _34:int = _focusIndex + _33*_32;
			if(_34 >=0 && _34 < _cellRenderers.length){
				var _35:int = int(_34/_33);
				setSelectedIndex(_35);
				dispatchEvent(new Event(Event.CHANGE,false));
				_focusIndex = _34;
			}
			FocusManager.setFocus(_cellRenderers[_focusIndex]);
			evt.stopPropagation();
		}
		protected override function onKeyDown(evt:KeyboardEvent):void {
			var _32:uint = getColumnCount();
			var _33:uint = getLength();
			if (_32 == 0 || _33 == 0) {
				return;
			}
			if (evt.keyCode == Keyboard.LEFT || evt.keyCode == Keyboard.RIGHT) {
				if (! horizontalScrollBar.getEnabled()) {
					return;
				}
				var _34:Number = horizontalScrollBar.getScrollPosition();
				var _35:Number = horizontalScrollBar.getLineScrollSize();
				if (evt.keyCode == Keyboard.LEFT) {
					if (_34 > horizontalScrollBar.getMinScrollPosition()) {
						horizontalScrollBar.setScrollPosition(_34 - _35);
					}
				} else if (evt.keyCode == Keyboard.RIGHT) {
					if (_34 < horizontalScrollBar.getMaxScrollPosition()) {
						horizontalScrollBar.setScrollPosition(_34 + _35);
					}
				}
				return;
			}
			if(_cellRenderer != null){
				_32 = 1;
			}
			var _36:int = -1;
			var _37:uint = _focusIndex == -1 ? 0 : _focusIndex%_32;
			var _38:Rectangle = content.scrollRect;
			switch (evt.keyCode) {
				case Keyboard.HOME :
					_36 = _37;
					break;
				case Keyboard.END :
					_36 = (_33 - 1)*_32 + _37;
					break;
				case Keyboard.UP :
					_36 = Math.max(_37,_focusIndex - _32);
					break;
				case Keyboard.DOWN :
					_36 = Math.min((_33 - 1)*_32+_37,_focusIndex + _32);
					break;
				case Keyboard.PAGE_UP :
					if (_33 == 1 || _38 == null || _focusIndex < _32) {
						_36 = _37;
					} else {
						var _39:DisplayObject = _cellRenderers[_focusIndex];
						var _40:Number = _39.height;
						var _41:Number = _39.y;
						_36 = _focusIndex - _32;
						var _42:Number = _cellRenderers[_36].y;
						_40 += _41 - _42;
						_41 = _42;
						while (_40 <= _38.height && _36 >= _32) {
							_39 = _cellRenderers[_36 - _32];
							_42 = _39.y;
							_40 +=  _41 - _42;
							_41 = _42;
							if (_40 <= _38.height) {
								_36 -= _32;
							}
						}
					}
					break;
				case Keyboard.PAGE_DOWN :
					if (_33 == 1 || _38 == null || _focusIndex >= (_33 - 1)*_32) {
						_36 = (_33 - 1)*_32 + _37;
					} else {
						_36 = Math.max(0,_focusIndex);
						_39 = _cellRenderers[_36];
						setVerticalScrollPosition(_39.y);
						_41 = _39.y;
						_36 = _focusIndex + _32;
						_42 = _cellRenderers[_36].y;
						_40 = _42 - _41;
						_41 = _42;
						while (_40 <= _38.height && _36 < (_33 - 1)*_32) {
							_39 = _cellRenderers[_36 + _32];
							_42 =  _39.y;
							_40 += _42 - _41;
							_41 = _42;
							if (_40 <= _38.height) {
								_36 += _32;
							}
						}
					}
					break;
				default :
					if(_cellRenderer == null){
						break;
					}
					var _43:String = String.fromCharCode(evt.charCode).toUpperCase(),_44:Stirng;
					var _45:uint = _focusIndex;
					while (true) {
						_45++;
						if (_45 == _33) {
							if (_focusIndex == -1) {
								break;
							}
							_45 = 0;
						}
						_44 = _cellRenderers[_45].getLabel();
						if (_44 != null && _44.toUpperCase().indexOf(_43) == 0) {
							_36 = _45;
							break;
						}
						if (_45 == _focusIndex) {
							break;
						}
					}
			}
			if (_36 == -1) {
				return;
			}
			var _46:int = int(_36/_32);
			if (! getSelectable()) {
				scrollToIndex(_46);
				return;
			}
			_focusIndex = _36;
			if (! getMultipleSelection()) {
				if (_selectedIndex == _46){
					return;
				}
				setSelectedIndex(_46);
			} else if (evt.shiftKey && _lastSelectedIndex != -1) {
				var _47:Array = [];
				var _48:int = _lastSelectedIndex < _46 ? 1:-1;
				for (var _49:int = _lastSelectedIndex; _49 != _46; _49 +=  _48) {
					_47.push(_49);
				}
				_47.push(_46);
				if (_47.toString() == _selectedIndices.toString()) {
					return;
				}
				_46 = _lastSelectedIndex;
				setSelectedIndices(_47);
				_lastSelectedIndex = _46;
			} else {
				if (_selectedIndices.length == 1 && _selectedIndices[0] == _46) {
					return;
				}
				setSelectedIndices([_46]);
			}
			_focusIndex = _36;
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected function onKeyFocusChange(evt:FocusEvent):void {
			if(evt.isDefaultPrevented()){
				return;
			}
			var _32:uint = getColumnCount();
			var _33:uint = getLength();
			if (_32 == 0 || _33 == 0) {
				return;
			}
			if(_focusIndex != -1){
				var _34:InteractiveObject = _cellRenderers[_focusIndex];
				var _35:InteractiveObject = stage.focus;
				if(_35 == null || (_35 != _34 && (!(_34 is DisplayObjectContainer) || !DisplayObjectContainer(_34).contains(_35)))){
					evt.preventDefault();
					stage.focus = _34;
					return;
				}
			}
			var _36:int = evt.shiftKey ? -1 : 1;
			var _37:int = _focusIndex + _36;
			if(_cellRenderer == null){
				while(_37 >=0 && _37 < _cellRenderers.length){
					if(getColumnEditable(_37%_32)){
						break;
					}
					_37 += _36;
				}
			}
			if(_37 >=0 && _37 < _cellRenderers.length){
				var _38:int = int(_37/_32);
				if(_selectedIndex != _38){
					setSelectedIndex(_38);
					dispatchEvent(new Event(Event.CHANGE,false));
				}
				_focusIndex = _37;
				evt.preventDefault();
				stage.focus = _cellRenderers[_37];
			}
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _32:Number = _width;
			var _33:Number = _height;
			skin.width = _32;
			skin.height = _33;
			var _34:String = getHorizontalScrollPolicy();
			var _35:String = getVerticalScrollPolicy();
			var _36:Number = _32 - _contentPaddingX * 2;
			var _37:Number = _33 - _contentPaddingY * 2;
			var _38:Number = _36 - verticalScrollBar.width;
			var _39:Number = _37 - horizontalScrollBar.height;
			var _40:Rectangle = new Rectangle(0,0,_36,_37);
			if(_34 == "on"){
				_40.width = _38;
				horizontalScrollBar.visible = true;
			}else{
				horizontalScrollBar.visible = false;
			}
			if(_35 == "on"){
				_40.height = _39;
				verticalScrollBar.visible = true;
			}else{
				verticalScrollBar.visible = false;
			}
			var _41:Rectangle = _40.clone();
			var _42:Number = 0;
			var _43:Boolean = false;
			var _44:uint = getColumnCount();
			for (var _45:int = 0; _45 < _44; _45++){
				var _46:Number = _11[_45];
				var _47:ToggleButton = _6[_45];
				_47.x = _42;
				_47.y = 0;
				_47.setSize(_46,_2);
				_42 += _46;
				if(_45 == _44-1 && _35 != "auto" && _42 != _40.width && !_43){
					autoResizeColumns();
					_43 = true;
					_45 = -1;
				}
			}
			var _48:Number = _25.width,_49:Number = 0;
			if (_34 == "auto" && _48 > _40.width) {
				horizontalScrollBar.visible = true;
				_40.height = _39;
			}
			if(_3){
				_25.visible = true;
				_26.y = _25.height;
				_41.height -= _25.height;
			}else{
				_25.visible = false;
				_26.y = 0;
			}
			var _50:int = 0;
			var _51:uint = getLength();
			var _52:Number = getRowHeight();
			if(_44 > 0){
				for (; _50 < _51; _50++) {
					var _53:DisplayObject;
					if(_cellRenderer != null){
						_46 = _48;
						_53 = _cellRenderers[_50];
						_53.y = _49;
						if(_22 && verticalLineSkin != null && _1 == AUTO_RESIZE_OFF){
							_46 -= verticalLineSkin.width;
						}
						ICellRenderer(_53).setSize(_48,_52);
						_49 +=  _53.height;
					}else{
						_42 = 0;
						var _54:Number = 0;
						for (_45 = 0; _45 < _44; _45++){
							_46 = _11[_45];
							_53 = _cellRenderers[_50*_44+_45];
							_53.x = _42;
							_53.y = _49;
							_42 += _46;
							if(_22 && verticalLineSkin != null && (_1 == AUTO_RESIZE_OFF || _45 != _44-1)){
								_46 -= verticalLineSkin.width;
							}
							IDataGridCellRenderer(_53).setSize(_46,_52);
							_54 = Math.max(_54, _53.height);
						}
						_49 += _53.height;
						if(_21 && horizontalLineSkin != null){
							var _55:DisplayObject;
							if(_50 == 0){
								_55 = horizontalLineSkin;
								if(!_23.contains(_55)){
									_23.addChild(_55);
								}
							}else{
								var _56:String = "horizontalLine" + _50;
								_55 = _23.getChildByName(_56);
								if(_55 == null){
									var _57:Class = horizontalLineSkin["constructor"] as Class;
									_55 = new _57() as DisplayObject;
									_55.name = _56;
									_23.addChild(_55);
								}
							}
							_55.x = 0;
							_55.y = _49;
							_55.width = _48;
							_49 += _55.height;
						}
					}
					if (_35 == "auto" && _40.width == _36 && _49 > _41.height) {
						verticalScrollBar.visible = true;
						_40.width = _41.width = _38;
						autoResizeColumns();
						_42 = 0;
						for (_45 = 0; _45 < _44; _45++){
							_46 = _11[_45];
							_47 = _6[_45];
							_47.x = _42;
							_47.setSize(_46,_2);
							_42 += _46;
						}
						_48 = _25.width;
						if (_34 == "auto" && _40.height == _37 && _48 > _40.width) {
							horizontalScrollBar.visible = true;
							_40.height = _39;
							if(_3){
								_41.height -= _25.height;
							}
						}
						_49 = 0;
						_50 = -1;
					}
				}
			}
			if(horizontalLineSkin != null){
				if(!_21){
					_50 = 0;
				}
				for(_51 = _23.numChildren; _50 < _51; _50++){
					_23.removeChildAt(_23.numChildren-1);
				}
			}
			_42 = 0;
			if(_1 != AUTO_RESIZE_OFF){
				_44 = Math.max(0,_44-1);
			}
			for (_45 = 0; _45 < _44; _45++){
				_46 = _11[_45];
				_42 += _46;
				if(_22 && verticalLineSkin != null){
					var _58:DisplayObject;
					if(_45 == 0){
						_58 = verticalLineSkin;
						if(!_24.contains(_58)){
							_24.addChild(_58);
						}
					}else{
						_56 = "verticalLine" + _45;
						_58 = _24.getChildByName(_56);
						if(_58 == null){
							var _59:Class = verticalLineSkin["constructor"] as Class;
							_58 = new _59() as DisplayObject;
							_58.name = _56;
							_24.addChild(_58);
						}
					}
					_58.x = _42 - _58.width;
					_58.y = 0;
					_58.height = _40.height;
				}
			}
			if(verticalLineSkin != null){
				if(!_22){
					_45 = 0;
				}
				for(_51 = _24.numChildren; _45 < _51; _45++){
					_24.removeChildAt(_24.numChildren-1);
				}
			}
			content.setSize(_48,_49);
			if (_48 <= _40.width && _49 <= _40.height) {
				content.scrollRect = null;
				_26.scrollRect = null;
				horizontalScrollBar.setEnabled(false);
				verticalScrollBar.setEnabled(false);
			} else {
				horizontalScrollBar.setMaxScrollPosition(Math.max(0,_48 - _40.width));
				verticalScrollBar.setMaxScrollPosition(Math.max(0,_49 - _41.height));
				if (content.scrollRect != null && _26.scrollRect != null) {
					_40.x = Math.min(content.scrollRect.x,horizontalScrollBar.getMaxScrollPosition());
					_41.y = Math.min(_26.scrollRect.y,verticalScrollBar.getMaxScrollPosition());
					_41.width = _40.x + _40.width;
				}
				content.scrollRect = _40;
				_26.scrollRect = _41;
				if (_48 > _40.width) {
					horizontalScrollBar.setEnabled(true);
					if (_hPageScrollSize <= 0) {
						horizontalScrollBar.setPageScrollSize(_40.width);
					}
					horizontalScrollBar.setScrollPosition(_40.x);
				} else {
					horizontalScrollBar.setEnabled(false);
				}
				if (_49 > _40.height) {
					verticalScrollBar.setEnabled(true);
					if (_vPageScrollSize <= 0) {
						verticalScrollBar.setPageScrollSize(Math.max(0,_41.height - _52));
					}
					if (_vLineScrollSize <= 0) {
						verticalScrollBar.setLineScrollSize(_52);
					}
					verticalScrollBar.setScrollPosition(_40.y);
				} else {
					verticalScrollBar.setEnabled(false);
				}
			}
			horizontalScrollBar.y = _33 - _contentPaddingY - horizontalScrollBar.height;
			verticalScrollBar.x = _32 - _contentPaddingX - verticalScrollBar.width;
			if (horizontalScrollBar.visible && verticalScrollBar.visible) {
				horizontalScrollBar.width = _36 - verticalScrollBar.width;
				verticalScrollBar.height = _37 - horizontalScrollBar.height;
			} else if (horizontalScrollBar.visible) {
				horizontalScrollBar.width = _36;
			} else if (verticalScrollBar.visible) {
				verticalScrollBar.height = _37;
			}
			if (focusRectSkin != null) {
				focusRectSkin.width = _32;
				focusRectSkin.height = _33;
			}
		}
	}
}

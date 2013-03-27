package shinater.swing{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import flash.xml.XMLNodeType;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import shinater.transitions.Tween;
	import shinater.transitions.TweenEvent;
	import shinater.swing.managers.StyleManager;
	import shinater.swing.managers.swing_style;

	
	public dynamic class Tree extends ScrollPane {
				private var _1:Class;
				protected var _dataProvider:XMLDocument = new XMLDocument();
		protected var _nodes:Array = [];
		protected var _cellRenderers:Array = [];
		protected var _displayedNodes:Array = [];
		protected var _displayedCellRenderers:Array = [];
		private var _2:Boolean = false;
				private var _3:Boolean = false;
				private var _4:Boolean = true;
				private var _5:int = -1;
		private var _6:int = -1;
				private var _7:Array = [];
		private var _8:int = -1;
		private var _9:Number = -1;
		private var _10:Boolean = false;
		public var content:Panel;
		
		use namespace swing_style;
		swing_style var tween:Tween;
		swing_style var tweenCellRenderers:Object;
		swing_style var tweenDisplayedCellRenderers:Object;
		
		public function Tree() {
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
			setCellRenderer(TreeCellRenderer);
		}
		public override function get tabChildren():Boolean{
			return false;
		}
		public override function drawFocus(focused:Boolean):void {
			if (focusRectSkin != null) {
				if(focusRectSkin.visible != focused){
					focusRectSkin.visible = focused;
				}
			}
		}
		public override function setContent(content:DisplayObject):void {
		}
		public override function getContent():DisplayObject {
			return content;
		}
		
		public function setCellRenderer(cellRenderer:Class):void {
			var _11:DisplayObject = DisplayObject(ITreeCellRenderer(new cellRenderer()));
			if (!_10) {
				_9 = _11.height;
			}
			_1 = cellRenderer;
			repaint();
		}
		
		public function getCellRenderer():Class {
			return _1;
		}
		
		public function setMultipleSelection(selectable:Boolean):void {
			if (_3 == selectable) {
				return;
			}
			if (! selectable) {
				if (_7.length > 1) {
					setSelectedIndices([_7[_7.length - 1]]);
				}
			} else {
				_7.splice(0);
				if (_5 != -1) {
					_7.push(_5);
				}
			}
			_3 = selectable;
		}
		
		public function getMultipleSelection():Boolean {
			return _3;
		}
		
		public function setSelectable(selectable:Boolean):void {
			if (! selectable) {
				clearSelection();
			}
			_4 = selectable;
		}
		
		public function getSelectable():Boolean {
			return _4;
		}
		
		public function setDataProvider(dataProvider:XML):void {
			removeAll();
			_dataProvider.attributes.data = dataProvider;
			refresh();
		}
		
		public function getDataProvider():XML {
			if(_dataProvider.nodeName == null){
				return new XML(_dataProvider.toString());
			}
			return new XML("<" + _dataProvider.nodeName + ">" + _dataProvider.toString() + "</" + _dataProvider.nodeName + ">");
		}
		
		public function addTreeNode(child:Object):void {
			var _11:XMLNode = _dataProvider.createElement("node");
			_11.attributes.data = child;
			_dataProvider.appendChild(_11);
			refresh();
		}
		
		public function addTreeNodeAt(child:Object,index:uint):void {
			var _11:XMLNode = _dataProvider.createElement("node");
			_11.attributes.data = child;
			_dataProvider.insertBefore(_11,_dataProvider.childNodes[index]);
			refresh();
		}
		
		public function getTreeNodeAt(index:uint):Object {
			var _11:XMLNode = _dataProvider.childNodes[index];
			if(_11 == null){
				return null;
			}
			return _11.attributes.data;
		}
		public function getLength():uint {
			return _displayedNodes.length;
		}
		
		public function replaceTreeNodeAt(child:Object,index:uint):Object {
			var _11:XMLNode = _dataProvider.childNodes[index];
			if(_11 == null){
				return null;
			}
			var _12:Object = _11.attributes.data;
			_11.attributes.data = child;
			refresh();
			return _12;
		}
		
		public function removeTreeNode(child:Object):Object {
			var _11:Array = _dataProvider.childNodes;
			for(var _12:int = 0,_13:uint = _11.length; _12 < _13; _12++){
				var _14:XMLNode = _11[_12];
				var _15:Object = _14.attributes.data;
				if(_15 == child){
					_14.removeNode();
					refresh();
					return _15;
				}
			}
			return null;
		}
		
		public function removeTreeNodeAt(index:uint):Object {
			var _11:XMLNode = _dataProvider.childNodes[index];
			if(_11 == null){
				return null;
			}
			var _12:Object = _11.attributes.data;
			_11.removeNode();
			refresh();
			return _12;
		}
		
		public function removeAll():void {
			_dataProvider.attributes.data = null;
			var _11:Array = _dataProvider.childNodes;
			for(var _12:int = _11.length-1; _12 >= 0; _12--){
				_11[_12].removeNode();
			}
			refresh();
		}
		
		public function getDisplayIndex(node:Object):int {
			return _displayedNodes.indexOf(node);
		}
		
		public function getNodeDisplayedAt(index:uint):Object {
			return _displayedNodes[index];
		}
		
		public function setRootVisible(rootVisible:Boolean):void{
			if(_2 == rootVisible){
				return;
			}
			_2 = rootVisible;
			refresh();
		}
		
		public function getRootVisible():Boolean{
			return _2;
		}
		
		public function refresh():void{
			var _11:Array = [];
			var _12:Array = [];
			var _13:Array = [];
			var _14:Array = [];
			var _15:Object = _dataProvider.attributes.data;
			var _16:Array = _dataProvider.childNodes;
			var rootVisible = getRootVisible() && _15 != null;
			var _17:int = 0;
			if(_15 != null && _16.length == 0){
				if(rootVisible){
					updateTreeModel(_15,_dataProvider,1,_17,true,_11,_12,_13,_14);
				}else{
					updateTreeModel(_15,_dataProvider,2,--_17,true,_11,_12,_13,_14);
				}
			}else{
				if(rootVisible){
					updateTreeModel(_15,_dataProvider,0,_17++,true,_11,_12,_13,_14);
				}
				for(var _18:int = 0, _19:uint = _16.length; _18 < _19; _18++){
					var _20:XMLNode = _16[_18];
					_15 = _20.attributes.data;
					updateTreeModel(_15,_20,1,_17,!rootVisible||_dataProvider.attributes.expanded,_11,_12,_13,_14);
				}
			}
			var _21:ITreeCellRenderer;
			for (_18 = _7.length; _18 >= 0; _18--) {
				_21 = _displayedCellRenderers[_7[_18]];
				var _22:int = _14.indexOf(_21);
				if(_22 == -1){
					_7.splice(_18,1);
				}else{
					_7[_18] = _22;
				}
			}
			if(_5 != -1){
				_21 = _displayedCellRenderers[_5];
				_5 = _14.indexOf(_21);
			}
			if(_6 != -1){
				_21 = _displayedCellRenderers[_6];
				_6 = _14.indexOf(_21);
			}
			if(_8 != -1){
				_21 = _displayedCellRenderers[_8];
				_8 = _14.indexOf(_21);
			}
			_nodes = _11;
			for(_18 = 0,_19 = _cellRenderers.length; _18<_19; _18++){
				_21 = _cellRenderers[_18];
				if(_21 != null && _12.indexOf(_21) == -1){
					var _23:DisplayObject = DisplayObject(_21);
					_23.removeEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown);
					_23.removeEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
					content.removeChild(_23);
				}
			}
			_cellRenderers = _12;
			_displayedNodes = _13;
			_displayedCellRenderers = _14;
			repaint();
		}
		private function updateTreeModel(node:Object, xmlNode:XMLNode, nodeType:int, depth:int, displayed:Boolean, nodes:Array, cellRenderers:Array, displayedNodes:Array, displayedCellRenderers:Array):void{
			var _11:Object = xmlNode.attributes.expanded;
			xmlNode.attributes = null;
			var _12:Boolean = false;
			var _13:String;
			var _14:Array = ["openIcon","closedIcon","leafIcon"];
			var _15:Array = [];
			var _16:Object = null;
			if(node is XML){
				_16 = node.children();
				_12 = _16.length() > 0;
				for each(var _17:XML in node.attribute){
					var _18:String = _17.name();
					if(!_12 && (_18 == "isBranch" || _18 == "isbranch")){
						_12 = _17 == "true";
						continue;
					}
					if(_12 && _11 == null && _18 == "expanded"){
						_11 = _17 == "true";
						continue;
					}
					for(var _19:int = 0; _19<3; _19++){
						var _20:String = _14[_19];
						if(_18 == _20 || _18 == _20.toLowerCase()){
							_15[_19] = _17;
							break;
						}
					}
					xmlNode.attributes[_18] = _17;
				}
				_13 = node.attribute("label") || node.name() || node.toString();
				xmlNode.nodeName = node.name();
			}else if(node is XMLNode){
				_16 = node.childNodes;
				_12 = _16.length > 0;
				for(_18 in node.attributes){
					if(!_12 && (_18 == "isBranch" || _18 == "isbranch")){
						_12 = node.attributes[_18] == "true";
						continue;
					}
					if(_12 && _11 == null && _18 == "expanded"){
						_11 = node.attributes[_18] == "true";
						continue;
					}
					for(_19 = 0; _19<3; _19++){
						_20 = _14[_19];
						if(_18 == _20 || _18 == _20.toLowerCase()){
							_15[_19] = node.attributes[_18];
							break;
						}
					}
					xmlNode.attributes[_18] = node.attributes[_18];
				}
				_13 = xmlNode.attributes["label"] || node.nodeName || node.nodeValue;
				xmlNode.nodeName = node.nodeName;
			}else if(node != null){
				if(node is Array){
					_16 = node;
					_12 = true;
				}else{
					if(node.hasOwnProperty("children") && (node.children is Array)){
						_16 = node.children;
						_12 = true;
					}else{
						_12 = node.hasOwnProperty("isBranch") && node.isBranch == true;
					}
				}
				if(_12 && _11 == null && node.hasOwnProperty("expanded")){
					_11 = node.expanded == true;
				}
				for(_19 = 0; _19<3; _19++){
					_20 = _14[_19];
					if(node.hasOwnProperty(_20)){
						_15[_19] = node[_20];
					}
				}
				if(node.hasOwnProperty("label") && node.label != null){
					_13 = node.label.toString();
				}else{
					_13 = node.toString();
				}
			}
			xmlNode.attributes.isBranch = _12;
			if(_12 && _11 != null){
				xmlNode.attributes.expanded = _11;
			}
			if(nodeType < 2){
				xmlNode.attributes.data = node;
				var _21:int = _nodes.indexOf(node);
				var _22:ITreeCellRenderer;
				if(_21 != -1){
					_22 = _cellRenderers[_21];
					_nodes[_21] = {};
					_cellRenderers[_21] = null;
				}else{
					_22 = createCellRenderer(node);
					var _23:DisplayObject = DisplayObject(_22);
					_23.addEventListener(MouseEvent.MOUSE_DOWN,onBeforeItemDown,false,1,true);
					_23.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown,false,0,true);
					content.addChild(_23);
				}
				_22.setLabel(_13);
				for(_19 = 0; _19<3; _19++){
					_20 = _14[_19];
					_20 = _20.charAt(0).toUpperCase() + _20.substr(1);
					var _24:Object = _15[_19];
					if(_24 is String){
						try{
							var _25:Class = getDefinitionByName(String(_24)) as Class;
							if(!(_22["get"+_20]() is _25)){
								_22["set"+_20](new _25() as DisplayObject);
							}
						}catch(e:ReferenceError){
						}
					}else{
						_22["set"+_20](_24 as DisplayObject);
					}
				}
				_22.setDepth(depth);
				_22.setIsBranch(_12);
				_22.setIsOpen(_11);
				if(displayed){
					_22.setIndex(displayedCellRenderers.length);
					displayedNodes.push(node);
					displayedCellRenderers.push(_22);
				}else{
					_22.setIndex(-1);
				}
				nodes.push(node);
				cellRenderers.push(_22);
			}
			if(nodeType == 0){
				return;
			}
			if(nodeType == 2){
				_11 = true;
			}
			var _26:Array = xmlNode.childNodes.slice();
			for(_19 = _26.length-1; _19 >= 0; _19--){
				_26[_19].removeNode();
			}
			if(_16 == null){
				return;
			}
			var _27:uint = _16.length || _16.length();
			if(_27 == 0){
				return;
			}
			var _28:XMLNode = xmlNode;
			for(_19 = 0; _19 < _27; _19++){
				node = _16[_19];
				xmlNode = null;
				for(var j = 0; j < _26.length; j++){
					var _29:XMLNode = _26[j];
					if(_29 != null && _29.attributes.data == node){
						xmlNode = _29;
						_26[j] = null;
						break;
					}
				}
				if(xmlNode == null){
					xmlNode = _dataProvider.createElement("node");
				}
				updateTreeModel(node, xmlNode, 1, depth+1, displayed&&_11, nodes, cellRenderers, displayedNodes, displayedCellRenderers);
				_28.appendChild(xmlNode);
			}
		}
		
		public function isNodeSelected(node:Object):Boolean {
			var _11:int = _displayedNodes.indexOf(node);
			if (_11 == -1) {
				return false;
			}
			return _7.indexOf(_11) != -1;
		}
		
		public function setSelectedIndex(index:int):void {
			if (! getSelectable()) {
				return;
			}
			if (getMultipleSelection()) {
				setSelectedIndices([index]);
				return;
			}
			if (_5 == index) {
				return;
			}
			if (_5 != -1) {
				_displayedCellRenderers[_5].setSelected(false);
			}
			_5 = _6 = index;
			if (_5 != -1) {
				_8 = index;
				_displayedCellRenderers[index].setSelected(true);
				scrollToIndex(index);
			}
		}
		
		public function getSelectedIndex():int {
			return _5;
		}
		
		public function setSelectedNode(node:Object):void {
			if (! getSelectable()) {
				return;
			}
			var _11:int = _displayedNodes.indexOf(node);
			if (_11 == -1) {
				return;
			}
			setSelectedIndex(_11);
		}
		
		public function getSelectedNode():Object {
			if (_5 == -1) {
				return null;
			}
			return _displayedNodes[_5];
		}
		
		public function setSelectedIndices(indices:Array):void {
			if (! getSelectable() || ! getMultipleSelection()) {
				return;
			}
			if ((indices == null && _7.length == 0) || (indices.toString() == _7.toString())) {
				return;
			}
			for (var _11:int = 0,_12:uint = _7.length; _11 < _12; _11++) {
				var _13:int = _7[_11];
				if (indices == null || indices.indexOf(_13) == -1) {
					_displayedCellRenderers[_13].setSelected(false);
				}
			}
			_5 = _6 = -1;
			_7.splice(0);
			if (indices != null && indices.length > 0) {
				for (_11 = 0,_12 = indices.length; _11 < _12; _11++) {
					_13 = indices[_11];
					if (_13 >= 0 && _13 < _displayedCellRenderers.length && _7.indexOf(_13) == -1) {
						_5 = _6 = _13;
						_7.push(_13);
						_8 = _13;
						var _14:ITreeCellRenderer = _displayedCellRenderers[_13];
						if (! _14.getSelected()) {
							_14.setSelected(true);
						}
					}
				}
				scrollToIndex(_5);
			}
		}
		
		public function getSelectedIndices():Array {
			if (! getMultipleSelection()) {
				return _5 != -1 ? [_5]:[];
			}
			return _7.slice();
		}
		
		public function setSelectedNodes(nodes:Array):void {
			if (! getSelectable() || ! getMultipleSelection()) {
				return;
			}
			var _11:Array = [];
			if (nodes != null) {
				for (var _12:int = 0,_13:uint = nodes.length; _12 < _13; _12++) {
					var _14:int = _displayedNodes.indexOf(nodes[_12]);
					while (_11.indexOf(_14) != -1) {
						_14 = _displayedNodes.indexOf(nodes[_12],_14 + 1);
					}
					if (_14 != -1) {
						_11.push(_14);
					}
				}
			}
			setSelectedIndices(_11);
		}
		
		public function getSelectedNodes():Array {
			if (! getMultipleSelection()) {
				return _5 != -1 ? [_displayedNodes[_5]]:[];
			}
			var _11:Array = [];
			for (var _12:int = 0,_13:uint = _7.length; _12 < _13; _12++) {
				_11.push(_displayedNodes[_7[_12]]);
			}
			return _11;
		}
		
		public function clearSelection():void {
			!getMultipleSelection() ? setSelectedIndex(-1) : setSelectedIndices([]);
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		
		
		
		
		public function scrollToIndex(index:int):void {
			if (index < 0 || index >= _displayedCellRenderers.length) {
				return;
			}
			var _11:Rectangle = content.scrollRect;
			if (_11 == null) {
				return;
			}
			var _12:Number = _11.y;
			var _13:DisplayObject = _displayedCellRenderers[index];
			var _14:Number = _13.y;
			if (_12 > _14) {
				setVerticalScrollPosition(_14);
			} else if (_12 < _14) {
				_14 = _14 + _13.height - _11.height;
				if (_12 < _14) {
					setVerticalScrollPosition(_14);
				}
			}
		}
		
		public function scrollToSelected():void {
			scrollToIndex(Math.max(0,_5));
		}
		
		public function setRowHeight(height:Number):void {
			_9 = height;
			_10 = true;
			repaint();
		}
		
		public function getRowHeight():Number {
			return _9;
		}
		
		public function setVisibleRowCount(rowCount:uint):void {
			setRowCount(rowCount);
		}
		
		public function getVisibleRowCount():uint {
			return getRowCount();
		}
		
		public function setRowCount(rowCount:uint):void {
			var _11:Number = content.y + _9 * rowCount;
			if (! horizontalScrollBar.visible) {
				_11 +=  content.y;
			} else {
				_11 +=  horizontalScrollBar.height + horizontalScrollBar.x;
			}
			height = _11;
		}
		
		public function getRowCount():uint {
			var _11:Number = height - content.y;
			if (! horizontalScrollBar.visible) {
				_11 -=  content.y;
			} else {
				_11 -=  horizontalScrollBar.height - horizontalScrollBar.x;
			}
			return Math.ceil(_11 / _9);
		}
		
		public function expand(node:Object):void{
			setIsOpen(node,true);
		}
		
		public function collapse(node:Object):void{
			setIsOpen(node,false);
		}
		
		[Event(name = "nodeOpen",type = "flash.events.Event")]
		
		[Event(name = "nodeClose",type = "flash.events.Event")]
		public function setIsOpen(node:Object,open:Boolean):void{
						var _11:int = -1;
			if(node is int){
				_11 = int(node);
				if(_11 >= 0 && _11 < _displayedNodes.length){
					_11 = _nodes.indexOf(_displayedNodes[_11]);
				}else{
					_11 = -1;
				}
			}
			if(_11 == -1 && _nodes.indexOf(node) == -1){
				return;
			}
			var _12:XMLNode = _2 && _dataProvider.attributes.data != null ? _dataProvider : _dataProvider.firstChild;
			var _13:Array = [];
			var _14:int = 0;
			while(_12 != null){
				if(_11 != -1 ? _14 == _11 : _12.attributes.data == node){
					if(!_12.hasChildNodes() && _12.attributes.isBranch != true){
						return;
					}
					var _15:Boolean = _12.attributes.expanded == true;
					if(_15 == open){
						return;
					}
					_12.attributes.expanded = open;
					var _16:ITreeCellRenderer = _cellRenderers[_14];
					_16.setIsOpen(open);
					_11 = _displayedCellRenderers.indexOf(_16);
					if(_11 == -1){
						return;
					}
					_11++;
					_12 = _12.firstChild;
					_13.splice(0);
					_15 = true;
					_14++;
					var _17:Array = [];
					var displayedChildrenIndexArray = [];
					while(_12 != null){
						if(_15){
							displayedChildrenIndexArray.push(_14);
						}
						if(_12.hasChildNodes()){
							if(_12.nextSibling != null){
								_13.push(_12.nextSibling);
								_17.push(_15);
							}
							_15 = _15 && _12.attributes.expanded == true;
							_12 = _12.firstChild;
						}else if(_12.nextSibling != null){
							_12 = _12.nextSibling;
						}else if(_13.length > 0){
							_12 = _13.pop();
							_15 = _17.pop();
						}else{
							break;
						}
						_14++;
					}
					var _18:uint = displayedChildrenIndexArray.length;
					if(_18 > 0){
						for (_14 = _7.length; _14 >= 0; _14--) {
							if(_7[_14] >= _11){
								if(!open){
									if(_7[_14]-_11 < _18){
										_displayedCellRenderers[_7[_14]].setSelected(false);
										_7.splice(_14,1);
									}else{
										_7[_14] -= _18;
									}
								}else{
									_7[_14] += _18;
								}
							}
						}
						if(_5 != -1 && _5 >= _11){
							if(!open){
								if(_5-_11 < _18){
									_displayedCellRenderers[_5].setSelected(false);
									_5 = -1;
								}else{
									_5 -= _18;
								}
							}else{
								_5 += _18;
							}
						}
						if(_6 != -1 && _6 >= _11){
							if(!open){
								_6 = _6-_11 < _18 ? -1 : _6 - _18;
							}else{
								_6 += _18;
							}
						}
						if(_8 != -1 && _8 >= _11){
							if(!open){
								_8 = _8-_11 < _18 ? -1 : _8 - _18;
							}else{
								_8 += _18;
							}
						}
						if(!open){
							_displayedNodes.splice(_11,_18);
							_displayedCellRenderers.splice(_11,_18);
						}else{
							for(_14 = _18-1; _14>=0; _14--){
								_displayedNodes.splice(_11,0,_nodes[displayedChildrenIndexArray[_14]]);
								_displayedCellRenderers.splice(_11,0,_cellRenderers[displayedChildrenIndexArray[_14]]);
							}
						}
						repaint();
											}
					return;
				}
				if(_12.hasChildNodes()){
					if(_12.nextSibling != null){
						_13.push(_12.nextSibling);
					}
					_12 = _12.firstChild;
					
				}else if(_12.nextSibling != null){
					_12 = _12.nextSibling;
				}else if(_13.length > 0){
					_12 = _13.pop();
				}else{
					break;
				}
				_14++;
			}
		}
		
		public function isExpanded(node:Object):Boolean{
			return getIsOpen(node);
		}
		
		public function isCollapsed(node:Object):Boolean{
			return !getIsOpen(node);
		}
		public function getIsOpen(node:Object):Boolean{
			var _11:int = -1;
			if(node is int){
				_11 = int(node);
				if(_11 >= 0 && _11 < _displayedNodes.length){
					_11 = _nodes.indexOf(_displayedNodes[_11]);
				}else{
					_11 = -1;
				}
			}
			if(_11 == -1 && _nodes.indexOf(node) == -1){
				return false;
			}
			var _12:XMLNode = _2 && _dataProvider.attributes.data != null ? _dataProvider : _dataProvider.firstChild;
			var _13:Array = [];
			var _14:int = 0;
			while(_12 != null){
				if(_11 != -1 ? _14 == _11 : _12.attributes.data == node){
					return _12.attributes.expanded == true;
				}
				if(_12.hasChildNodes()){
					if(_12.nextSibling != null){
						_13.push(_12.nextSibling);
					}
					_12 = _12.firstChild;
				}else if(_12.nextSibling != null){
					_12 = _12.nextSibling;
				}else if(_13.length > 0){
					_12 = _13.pop();
				}else{
					break;
				}
				_14++;
			}
			return false;
		}
		protected function createCellRenderer(value:Object):ITreeCellRenderer {
						var _11:ITreeCellRenderer = new _1();
			_11.setOwner(this);
			_11.setData(value);
			return _11;
		}
		
		public function nodeToCellRenderer(node:Object):ITreeCellRenderer {
			var _11:int = _nodes.indexOf(node);
			if (_11 == -1) {
				return null;
			}
			return _cellRenderers[_11];
		}
		protected function onBeforeItemDown(evt:MouseEvent):void{
			var _11:int = _displayedCellRenderers.indexOf(evt.currentTarget);
			if(_11 == -1){
				evt.stopImmediatePropagation();
			}
		}
		protected function onItemDown(evt:MouseEvent):void {
			var _11:ITreeCellRenderer = ITreeCellRenderer(evt.currentTarget);
			var _12:int = _displayedCellRenderers.indexOf(_11);
			if (_12 == -1){
				return;
			}
			var _13:Boolean = _11.getIsOpen();
			if (_13 != isExpanded(_12)){
				setIsOpen(_12,_13);
				DisplayObject(_11).dispatchEvent(new Event(_13 ? "nodeOpen" : "nodeClose",true));
				return;
			}
			if (! getSelectable()) {
				if (_11.getSelected()){
					_11.setSelected(false);
				}
				scrollToIndex(_12);
				return;
			}
			if (! _11.getSelected() && (! getMultipleSelection() || ! evt.ctrlKey)){
				_11.setSelected(true);
			}
			if (! getMultipleSelection()) {
				if (_5 == _12){
					return;
				}
				setSelectedIndex(_12);
			} else if (evt.ctrlKey) {
				var _14:Array = getSelectedIndices();
				if (_11.getSelected()) {
					_14.push(_12);
				} else {
					_14.splice(_14.indexOf(_12),1);
				}
				setSelectedIndices(_14);
				_8 = _6 = _12;
			} else if (evt.shiftKey && _6 != -1) {
				_14 = [];
				var _15:int = _6 < _12 ? 1:-1;
				for (var _16:int = _6; _16 != _12; _16 += _15) {
					_14.push(_16);
				}
				_14.push(_12);
				if (_14.toString() == _7.toString()) {
					return;
				}
				_12 = _6;
				setSelectedIndices(_14);
				_6 = _12;
			} else {
				if (_7.length == 1 && _7[0] == _12) {
					return;
				}
				setSelectedIndices([_12]);
			}
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected override function onKeyDown(evt:KeyboardEvent):void {
						var _11:uint = getLength();
			if (_11 == 0) {
				return;
			}
			if (evt.ctrlKey && (evt.keyCode == Keyboard.LEFT || evt.keyCode == Keyboard.RIGHT)) {
				if (! horizontalScrollBar.getEnabled()) {
					return;
				}
				var _12:Number = horizontalScrollBar.getScrollPosition();
				var _13:Number = horizontalScrollBar.getLineScrollSize();
				if (evt.keyCode == Keyboard.LEFT) {
					if (_12 > horizontalScrollBar.getMinScrollPosition()) {
						horizontalScrollBar.setScrollPosition(_12 - _13);
					}
				} else if (evt.keyCode == Keyboard.RIGHT) {
					if (_12 < horizontalScrollBar.getMaxScrollPosition()) {
						horizontalScrollBar.setScrollPosition(_12 + _13);
					}
				}
				return;
			}
			var _14:DisplayObject;
			var _15:int = -1;
			if (evt.keyCode == Keyboard.SPACE || evt.keyCode == Keyboard.LEFT || evt.keyCode == Keyboard.RIGHT){
				if(_5 == -1){
					return;
				}
				_14 = _displayedCellRenderers[_5];
				_15 = _cellRenderers.indexOf(_14);
				var _16:XMLNode = _2 && _dataProvider.attributes.data != null ? _dataProvider : _dataProvider.firstChild;
				var _17:Array = [];
				var _18:int = 0;
				while(_16 != null && _18 != _15){
					if(_16.hasChildNodes()){
						if(_16.nextSibling != null){
							_17.push(_16.nextSibling);
						}
						_16 = _16.firstChild;
					}else if(_16.nextSibling != null){
						_16 = _16.nextSibling;
					}else if(_17.length > 0){
						_16 = _17.pop();
					}else{
						break;
					}
					_18++;
				}
				var _19:Boolean = _16.hasChildNodes() || _16.attributes.isBranch == true;
				var _20:Boolean = _16.attributes.expanded == true;
				if(evt.keyCode == Keyboard.SPACE){
					if(_19){
						setIsOpen(_5,!_20);
						_14.dispatchEvent(new Event(_20 ? "nodeClose" : "nodeOpen",true));
					}
					return;
				}
				if(evt.keyCode == Keyboard.RIGHT){
					if(!_19){
						return;
					}
					if(!_20){
						setIsOpen(_5,true);
						_14.dispatchEvent(new Event("nodeOpen",true));
						return;
					}
					if(_16.firstChild == null){
						return;
					}
					_15 = _5 + 1;
				}else if(evt.keyCode == Keyboard.LEFT){
					if(_19 && _20){
						setIsOpen(_5,false);
						_14.dispatchEvent(new Event("nodeClose",true));
						return;
					}
					var _21:XMLNode = _16.parentNode;
					if(_21 == null || (_21 == _dataProvider && (!_2 || _dataProvider.attributes.data == null))){
						return;
					}
					_15 = _5 - _21.childNodes.indexOf(_16) - 1;
				}
			}
			var _22:Rectangle = content.scrollRect;
			switch (evt.keyCode) {
				case Keyboard.HOME :
					_15 = 0;
					break;
				case Keyboard.END :
					_15 = _11 - 1;
					break;
				case Keyboard.UP :
					_15 = Math.max(0,_8 - 1);
					break;
				case Keyboard.DOWN :
					_15 = Math.min(_11 - 1,_8 + 1);
					break;
				case Keyboard.PAGE_UP :
					if (_11 == 1 || _22 == null || _8 < 1) {
						_15 = 0;
					} else {
						_14 = _displayedCellRenderers[_8];
						var _23:Number = _14.height;
						_15 = _8 - 1;
						_23 +=  _displayedCellRenderers[_15].height;
						while (_23 <= _22.height && _15 > 0) {
							_14 = _displayedCellRenderers[_15 - 1];
							_23 +=  _14.height;
							if (_23 <= _22.height) {
								_15--;
							}
						}
					}
					break;
				case Keyboard.PAGE_DOWN :
					if (_11 == 1 || _22 == null || _8 == _11 - 1) {
						_15 = _11 - 1;
					} else {
						_15 = Math.max(0,_8);
						_14 = _displayedCellRenderers[_15];
						setVerticalScrollPosition(_14.y);
						_23 = _14.height;
						_15++;
						_23 +=  _displayedCellRenderers[_15].height;
						while (_23 <= _22.height && _15 + 1 < _11) {
							_14 = _displayedCellRenderers[_15 + 1];
							_23 +=  _14.height;
							if (_23 <= _22.height) {
								_15++;
							}
						}
					}
					break;
				default :
					var _24:String = String.fromCharCode(evt.charCode).toUpperCase(),_25:Stirng;
					var _26:uint = _8;
					while (true) {
						_26++;
						if (_26 == _11) {
							if (_8 == -1) {
								break;
							}
							_26 = 0;
						}
						_25 = _displayedCellRenderers[_26].getLabel();
						if (_25 != null && _25.toUpperCase().indexOf(_24) == 0) {
							_15 = _26;
							break;
						}
						if (_26 == _8) {
							break;
						}
					}
			}
			if (_15 == -1) {
				return;
			}
			if (! getSelectable()) {
				scrollToIndex(_15);
				return;
			}
			if (! getMultipleSelection()) {
				if (_5 == _15){
					return;
				}
				setSelectedIndex(_15);
			} else if (evt.shiftKey && _6 != -1) {
				var _27:Array = [];
				var _28:int = _6 < _15 ? 1:-1;
				for (_18 = _6; _18 != _15; _18 += _28) {
					_27.push(_18);
				}
				_27.push(_15);
				if (_27.toString() == _7.toString()) {
					return;
				}
				_15 = _6;
				setSelectedIndices(_27);
				_6 = _15;
			} else {
				if (_7.length == 1 && _7[0] == _15) {
					return;
				}
				setSelectedIndices([_15]);
			}
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _11:Number = _width;
			var _12:Number = _height;
			skin.width = _11;
			skin.height = _12;
			var _13:Number = _11 - _contentPaddingX * 2;
			var _14:Number = _12 - _contentPaddingY * 2;
			var _15:String = _displayedCellRenderers.toString();
			var _16:Boolean = tweenCellRenderers == _cellRenderers && tweenDisplayedCellRenderers != _15;
			tweenCellRenderers = _cellRenderers;
			tweenDisplayedCellRenderers = _15;
			var _17:Tween = tween;
			if(_17 != null && _17.isPlaying){
				_17.stop();
			}
			if(!_16){
				var _18:String = getHorizontalScrollPolicy();
				var _19:String = getVerticalScrollPolicy();
				var _20:Number = _13 - verticalScrollBar.width;
				var _21:Number = _14 - horizontalScrollBar.height;
				var _22:Rectangle = new Rectangle(0,0,_13,_14);
				if(_18 == "on"){
					_22.width = _20;
					horizontalScrollBar.visible = true;
				}else{
					horizontalScrollBar.visible = false;
				}
				if(_19 == "on"){
					_22.height = _21;
					verticalScrollBar.visible = true;
				}else{
					verticalScrollBar.visible = false;
				}
				var _23:Number = 0,_24:Number = 0;
				for (var _25:int = 0,_26:uint = _cellRenderers.length; _25 < _26; _25++) {
					var _27:DisplayObject = _cellRenderers[_25];
					_27.scrollRect = null;
					ITreeCellRenderer(_27).setSize(_22.width,_9);
					if(_displayedCellRenderers.indexOf(_27) == -1){
						_27.visible = false;
						continue;
					}
					_27.visible = true;
					_27.y = _23;
					_23 +=  _27.height;
					_24 = Math.max(_24,_27.width);
					if (_18 == "auto" && _22.height == _14 && _24 > _22.width) {
						_22.height = _21;
						horizontalScrollBar.visible = true;
					}
					if (_19 == "auto" && _22.width == _13 && _23 > _22.height) {
						_22.width = _20;
						verticalScrollBar.visible = true;
						_23 = _24 = 0;
						_25 = -1;
					}
				}
				content.setSize(_24,_23);
				if (_24 <= _22.width && _23 <= _22.height) {
					content.scrollRect = _22;
					horizontalScrollBar.setEnabled(false);
					verticalScrollBar.setEnabled(false);
				} else {
					horizontalScrollBar.setMaxScrollPosition(Math.max(0,_24 - _22.width));
					verticalScrollBar.setMaxScrollPosition(Math.max(0,_23 - _22.height));
					if (content.scrollRect != null) {
						_22.x = Math.min(content.scrollRect.x,horizontalScrollBar.getMaxScrollPosition());
						_22.y = Math.min(content.scrollRect.y,verticalScrollBar.getMaxScrollPosition());
					}
					content.scrollRect = _22;
					if (_24 > _22.width) {
						horizontalScrollBar.setEnabled(true);
						if (_hPageScrollSize <= 0) {
							horizontalScrollBar.setPageScrollSize(_22.width);
						}
						horizontalScrollBar.setScrollPosition(_22.x);
					} else {
						horizontalScrollBar.setEnabled(false);
					}
					if (_23 > _22.height) {
						verticalScrollBar.setEnabled(true);
						if (_vPageScrollSize <= 0) {
							verticalScrollBar.setPageScrollSize(Math.max(0,_22.height - _9));
						}
						if (_vLineScrollSize <= 0) {
							verticalScrollBar.setLineScrollSize(_9);
						}
						verticalScrollBar.setScrollPosition(_22.y);
					} else {
						verticalScrollBar.setEnabled(false);
					}
				}
				horizontalScrollBar.y = _12 - _contentPaddingY - horizontalScrollBar.height;
				verticalScrollBar.x = _11 - _contentPaddingX - verticalScrollBar.width;
				if (horizontalScrollBar.visible && verticalScrollBar.visible) {
					horizontalScrollBar.width = _13 - verticalScrollBar.width;
					verticalScrollBar.height = _14 - horizontalScrollBar.height;
				} else if (horizontalScrollBar.visible) {
					horizontalScrollBar.width = _13;
				} else if (verticalScrollBar.visible) {
					verticalScrollBar.height = _14;
				}
				if (focusRectSkin != null) {
					focusRectSkin.width = _11;
					focusRectSkin.height = _12;
				}
				return;
			}
			var _28:Number = 0;
			var _29:Array = [];
			var _30:Array = [];
			var _31:Array = [];
			var _32:Array = [];
			var _33:Array = [];
			var _34:Array = [];
			var _35:Array = [];
			var _36:Array = [];
			for (_25 = 1,_26 = _cellRenderers.length; _25 < _26; _25++) {
				var _37:ITreeCellRenderer = _cellRenderers[_25-1];
				_27 = _cellRenderers[_25];
				var _38:int = _37.getDepth();
				var _39:int = ITreeCellRenderer(_27).getDepth();
				var _40:Boolean = _37.getIsBranch() && _38 == _39-1;
				if(_40){
					var _41:Boolean = _37.getIsOpen();
					var _42:Boolean = _27.visible;
					if(!_41 && !_42){
						var _43:int = _25 + 1;
						while(_43 < _26){
							if(_cellRenderers[_43].getDepth() <= _38){
								break;
							}
							_43++;
						}
						_25 = _43 - 1;
						continue;
					}
					if(!_27.visible && _29.length > 0 && _29[_29.length-1].getDepth() < _39){
						_33[_33.length-1] += _27.height;
						_27.visible = true;
						continue;
					}
					var _44:DisplayObject = DisplayObject(_37);
					var _45:Number = _44.height;
					var _46:Number = _27.height;
					var _47:Rectangle = _44.scrollRect;
					var _48:Number = _47 == null ? _44.y : _44.y - _47.y;
					_47 = _27.scrollRect;
					var _49:Number = _47 == null ? _27.y : _27.y - _47.y;
					_49 = _49 - _48 - _45;
					if(!_41 || (_41 && (!_42 || _49 < 0))){
						_29.push(_27);
						_30.push(_25);
						if(!_41){
							_31.push(_49);
							_32.push(undefined);
						}else{
							if(_42){
								_31.push(_49);
							}else{
								_31.push(undefined);
								_27.visible = true;
							}
							_32.push(0);
						}
						_33.push(_46);
						continue;
					}
				}
				if(_29.length == 0){
					continue;
				}
				var _50:ITreeCellRenderer = _29[_29.length-1];
				while(_39 < _50.getDepth()){
					_29.pop();
					_34.push(_30.pop());
					_14 = _33.pop();
					var _51:Number = _31.pop();
					if(isNaN(_51)){
						_51 = -_14;
					}
					_35.push(_51);
					var _52:Number = _32.pop();
					if(isNaN(_52)){
						_52 = -_14;
					}
					_36.push(_52);
					_28 = Math.max(_28, Math.abs(_52-_51));
					if(_29.length > 0){
						_50 = _29[_29.length-1];
						if(_52 > _51){
							_33[_33.length-1] += _14;
						}
					}else{
						break;
					}
				}
				if(_29.length == 0){
					continue;
				}
				_33[_33.length-1] += _27.height;
				_27.visible = true;
			}
			while(_29.length > 0){
				_29.pop();
				_34.push(_30.pop());
				_14 = _33.pop();
				_51 = _31.pop();
				if(isNaN(_51)){
					_51 = -_14;
				}
				_35.push(_51);
				_52 = _32.pop();
				if(isNaN(_52)){
					_52 = -_14;
				}
				_36.push(_52);
				_28 = Math.max(_28, Math.abs(_52-_51));
				if(_29.length > 0){
					if(_52 > _51){
						_33[_33.length-1] += _14;
					}
				}
			}
			if(_34.length == 0){
				return;
			}
			_34.push("-");
			_34 = _34.concat(_35);
			_34.push("-");
			_34 = _34.concat(_36);
			if(_17 == null){
				_17 = tween = new Tween(this,_34.toString(),null,0,_28,0.1,true);
				_17.addEventListener(TweenEvent.MOTION_CHANGE,function(evt:TweenEvent){
					var _17:Tween = Tween(evt.currentTarget);
					var _54:Tree = Tree(_17.obj);
					var _34:Array = _17.prop.split(",-,");
					var _35:Array = _34[1].split(",");
					var _36:Array = _34[2].split(",");
					_34 = _34[0].split(",");
					var _58:Array = _54._cellRenderers;
					var _59:Number = 0;
					var _60:Number = 0;
					for(var _25:int = 0,_26:uint = _58.length; _25<_26; _25++){
						var _27:DisplayObject = _58[_25];
						if(!_27.visible){
							continue;
						}
						var _64:int = _34.indexOf(_25.toString());
						if(_64 != -1){
							_59 = _60;
							var _65:Number = evt.position;
							var _51:Number = Number(_35[_64]);
							var _52:Number = Number(_36[_64]);
							if(_52 > _51){
								_65 = Math.min(_52,_51+_65);
							}else{
								_65 = Math.max(_52,_51-_65);
							}
							_60 += _65;
						}
						if(_60 >= _59){
							_27.scrollRect = null;
							_27.y = _60;
						}else{
							var _47:Rectangle = _27.scrollRect;
							if(_47 == null){
								_47 = new Rectangle(0,0,_27.width,_27.height);
							}
							_47.y = _59 - _60;
							_27.scrollRect = _47;
							_27.y = _60 + _47.y;
						}
						_60 += _27.height;
					}
					evt.updateAfterEvent();
				});
				_17.addEventListener(TweenEvent.MOTION_FINISH,function(evt:TweenEvent){
					var _17:Tween = Tween(evt.currentTarget);
					var _54:Tree = Tree(_17.obj);   
					_54.repaint();
				});
			}else{
				_17.prop = _34.toString();
				_17.begin = 0;
				_17.finish = _28;
				_17.start();
			}
		}
	}
}

package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.geom.Transform;
	import shinater.transitions.Tween;
	import shinater.transitions.TweenEvent;
	import shinater.swing.managers.FocusManager;
	import shinater.swing.managers.StyleManager;
	import shinater.swing.managers.swing_style;
	
	
	public dynamic class Accordion extends Container {
		private var _1:Boolean = false;
		private var _2:int = -1;
		private var _3:Array = [];
		private var _4:int = -1;
		protected var _headers:Array = [];
		protected var _items:Array = [];
		protected var _width:Number;
		protected var _height:Number;
		protected var _contentPaddingX:Number = 0;
		protected var _contentPaddingY:Number = 0;
		
		use namespace swing_style;
		swing_style var tween:Tween;
		swing_style var tweenLength:uint;
		
		public var skin:Sprite;
				
		public var header:ToggleButton;
		
		public function Accordion() {
			super();
		}
		protected override function init():void {
			_width = super.width;
			_height = super.height;
			scaleX = scaleY = 1;
			super.init();
			_contentPaddingX = header.x;
			_contentPaddingY = header.y;
						header.tabEnabled = false;
			removeChild(header);
			addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
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
		public override function get tabChildren():Boolean{
			return false;
		}
		public override function getFocusEnabled():Boolean {
			if(getLength() == 0){
				return false;
			}
			return super.getFocusEnabled();
		}
		public override function setFocus():void {
			if(!getFocusEnabled()) {
				return;
			}
			FocusManager.setFocus(_headers[_4 != -1 ? _4 : 0]);
		}
		public override function drawFocus(focused:Boolean):void {
			if(getLength() == 0){
				return;
			}
			_headers[_4 != -1 ? _4 : 0].drawFocus(focused);
		}
		
		public function setMultipleSelection(selectable:Boolean):void {
			if (_1 == selectable) {
				return;
			}
			if (! selectable) {
				if (_3.length > 1) {
					setSelectedIndices([_3[_3.length - 1]]);
				}
			} else {
				_3.splice(0);
				if (_2 != -1) {
					_3.push(_2);
				}
			}
			_1 = selectable;
		}
		
		public function getMultipleSelection():Boolean {
			return _1;
		}
		
		public function addItem(item:DisplayObject,title:String, icon:DisplayObject = null):void {
			addItemAt(item,title,getLength(),icon);
		}
		
		public function addItemAt(item:DisplayObject,title:String, index:uint, icon:DisplayObject = null):void {
			var _5:ToggleButton;
			if (index == 0) {
				_5 = header;
				if (_headers.length > 0 && _headers[0] == header) {
					var _6:ToggleButton = createHeaderComponent(header.getLabel(),header.getIcon());
					_6.setSelected(header.getSelected());
					_6.addEventListener(MouseEvent.CLICK,onHeaderClick,false,0,true);
					addChildAt(_6, getChildIndex(header) + 1);
					_headers[0] = _6;
				}else{
					_5.addEventListener(MouseEvent.CLICK,onHeaderClick,false,0,true);
					addChildAt(_5,1);
				}
				_5.setLabel(title);
				_5.setIcon(icon);
				_5.setSelected(false);
				addChildAt(item, getChildIndex(_5)+1);
			} else {
				_5 = createHeaderComponent(title,icon);
				_5.addEventListener(MouseEvent.CLICK,onHeaderClick,false,0,true);
				var _7:uint = index < _items.length ? getChildIndex(_headers[index]):numChildren;
				addChildAt(_5,_7);
				addChildAt(item, _7+1);
			}
			_headers.splice(index,0,_5);
			_items.splice(index,0,item);
			if (_items.length == 1) {
				setSelectedIndex(0);
				return;
			}
						for (var _8:int = 0,_9:uint = _3.length; _8 < _9; _8++) {
				if (_3[_8] >= index) {
					_3[_8] = _3[_8] + 1;
				}
			}
			if (_2 >= index) {
				_2++;
			}
			if (_4 >= index) {
				_4++;
			}
			repaint();
		}
		
		public function getItemAt(index:uint):DisplayObject {
			return _items[index];
		}
		
		public function getItemCount():uint {
			return getLength();
		}
		
		public function getLength():uint {
			return _items.length;
		}
		
		public function removeAll():void {
			for (var _5:int = _items.length - 1; _5 >= 0; _5--) {
				var _6:ToggleButton = _headers[_5];
				_6.removeEventListener(MouseEvent.CLICK, onHeaderClick);
				removeChild(_6);
				var _7:DisplayObject = _items[_5];
				removeChild(_7);
				_7.visible = true;
			}
			_headers.splice(0);
			_items.splice(0);
			_2 = _4 = -1;
			_3.splice(0);
			repaint();
		}
		
		public function removeItemAt(index:uint):DisplayObject {
			var _5:ToggleButton = _headers[index];
			_5.removeEventListener(MouseEvent.CLICK, onHeaderClick);
			removeChild(_5);
			_headers.splice(index,1);
			var _6:DisplayObject = _items[index];
			removeChild(_6);
			_6.visible = true;
			_items.splice(index,1);
			for (var _7:int = _3.length; _7 >= 0; _7--) {
				if (_3[_7] == index) {
					_3.splice(_7,1);
				} else if (_3[_7] > index) {
					_3[_7] = _3[_7] - 1;
				}
			}
			if (_2 == index) {
				_2 = -1;
				if(!_1 && _items.length > 0){
					setSelectedIndex(Math.min(index,_items.length-1));
					return _6;
				}
			} else if (_2 > index) {
				_2--;
			}
			if (_4 == index) {
				_4 = -1;
			} else if (_4 > index) {
				_4--;
			}
			repaint();
			return _6;
		}
		
		public function setTitleAt(title:String,index:uint):void {
			if(index >= _items.length){
				throw new RangeError();
			}
			_headers[index].setLabel(title);
		}
		
		public function getTitleAt(index:uint):String {
			if(index >= _items.length){
				throw new RangeError();
			}
			return _headers[index].getLabel();
		}
		
		public function setIconAt(icon:DisplayObject,index:uint):void {
			if(index >= _items.length){
				throw new RangeError();
			}
			_headers[index].setIcon(icon);
		}
		
		public function getIconAt(index:uint):DisplayObject {
			if(index >= _items.length){
				throw new RangeError();
			}
			return _headers[index].getIcon();
		}
		
		public function getHeaderAt(index:uint):ToggleButton{
			return _headers[index];
		}
		
		public function setSelectedIndex(index:int):void {
			if (getMultipleSelection()) {
				setSelectedIndices([index]);
				return;
			}
			if (_2 == index) {
				return;
			}
			if (_2 != -1) {
				_headers[_2].setSelected(false);
							}
			_2 = index;
			if (_2 != -1) {
				_4 = index;
				_headers[index].setSelected(true);
							}
			repaint();
		}
		
		public function getSelectedIndex():int {
			return _2;
		}
		
		public function setSelectedIndices(indices:Array):void {
						if (! getMultipleSelection()) {
				return;
			}
			if ((indices == null && _3.length == 0) || (indices.toString() == _3.toString())) {
				return;
			}
			for (var _5:int = 0,_6:uint = _3.length; _5 < _6; _5++) {
				var _7:int = _3[_5];
				if (indices == null || indices.indexOf(_7) == -1) {
					_headers[_7].setSelected(false);
									}
			}
			_3.splice(0);
			if (indices == null || indices.length == 0) {
				_2 = -1;
			} else {
				for (_5 = 0,_6 = indices.length; _5 < _6; _5++) {
					_7 = indices[_5];
					if (_7 >= 0 && _7 < _items.length && _3.indexOf(_7) == -1) {
						_2 = _7;
						_3.push(_7);
						_4 = _7;
						var _8:ToggleButton = _headers[_7];
						if (! _8.getSelected()) {
							_8.setSelected(true);
													}
					}
				}
			}
			repaint();
		}
		
		public function getSelectedIndices():Array {
			if (! getMultipleSelection()) {
				return _2 != -1 ? [_2]:[];
			}
			return _3.slice();
		}
		
		public function setSelectedItem(item:DisplayObject):void {
			var _5:int = _items.indexOf(item);
			if (_5 == -1) {
				return;
			}
			setSelectedIndex(_5);
		}
		
		public function getSelectedItem():DisplayObject {
			if (_2 == -1) {
				return null;
			}
			return _items[_2];
		}
		
		public function setSelectedItems(items:Array):void {
			if (! getMultipleSelection()) {
				return;
			}
			var _5:Array = [];
			if (items != null) {
				for (var _6:Number = 0,_7:uint = items.length; _6 < _7; _6++) {
					var _8:int = _items.indexOf(items[_6]);
					while (_5.indexOf(_8) != -1) {
						_8 = _items.indexOf(items[_6],_8 + 1);
					}
					if (_8 != -1) {
						_5.push(_8);
					}
				}
			}
			setSelectedIndices(_5);
		}
		
		public function getSelectedItems():Array {
			if (! getMultipleSelection()) {
				return _2 != -1 ? [_items[_2]]:[];
			}
			var _5:Array = [];
			for (var _6:int = 0,_7:uint = _3.length; _6 < _7; _6++) {
				_5.push(_items[_3[_6]]);
			}
			return _5;
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		
		
		
		protected function createHeaderComponent(title:String, icon:DisplayObject):ToggleButton {
			var _5:Class = header["constructor"] as Class;
			var _6:ToggleButton = new _5() as ToggleButton;
			_6.setLabel(title);
			_6.setIcon(icon);
						_6.tabEnabled = false;
			return _6;
		}
		protected function onHeaderClick(evt:MouseEvent):void {
			var _5:ToggleButton = ToggleButton(evt.currentTarget);
			var _6:Number = _headers.indexOf(_5);
			if (! getMultipleSelection()) {
				if(!_5.getSelected()){
					_5.setSelected(true);
					return;
				}
				setSelectedIndex(_6);
			}else{
				var _7:Array = getSelectedIndices();
				if (_5.getSelected()) {
					_7.push(_6);
				} else {
					_7.splice(_7.indexOf(_6),1);
				}
				setSelectedIndices(_7);
				_4 = _6;
			}
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected function onKeyDown(evt:KeyboardEvent):void {
			var _5:uint = getLength();
			if (_5 == 0) {
				return;
			}
			if (evt.keyCode == Keyboard.UP) {
				_4 = Math.max(0,_4 - 1);
								FocusManager.setFocus(_headers[_4]);
				_headers[_4].drawFocus(true);
			} else if (evt.keyCode == Keyboard.DOWN) {
				_4 = Math.min(_5 - 1,_4 + 1);
								FocusManager.setFocus(_headers[_4]);
				_headers[_4].drawFocus(true);
			} else if ((evt.keyCode == Keyboard.ENTER ) && _4 >= 0) {
				var _6:ToggleButton = _headers[_4];
				if (! getMultipleSelection()) {
					if(_6.getSelected()){
						return;
					}
					setSelectedIndex(_4);
				} else {
					var _7:Array = getSelectedIndices();
					var _8:int = _4;
					if (_6.getSelected()) {
						_7.push(_8);
					} else {
						_7.splice(_7.indexOf(_8),1);
					}
					setSelectedIndices(_7);
					_4 = _8;
				}
				evt.stopPropagation();
				dispatchEvent(new Event(Event.CHANGE,false));
			}
		}
		public override function repaint():void {
						if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _5:Number = _width;
			var _6:Number = _height;
			skin.width = _5;
			skin.height = _6;
			var _7:uint = getLength();
			var _8:Boolean = tweenLength == _7;
			tweenLength = _7;
			var _9:Tween = tween;
			if(_9 != null && _9.isPlaying){
				_9.stop();
			}
			if (_7 == 0) {
				return;
			}
			_5 -= _contentPaddingX * 2;
			_6 -= _contentPaddingY * 2 + 1;
			var _10:Number = _6 - header.height * _7;
			var _11:Array = getSelectedIndices();
			var _12:uint = _11.length;
			var y = _contentPaddingY;
			if(!_8){
				for (var _13:int = 0; _13<_7; _13++) {
					var _14:DisplayObject = _headers[_13];
					_14.width = _5;
					_14.x = _contentPaddingX;
					_14.y = y;
					y +=  _14.height;
					var _15:DisplayObject = _items[_13];
					_15.x = _contentPaddingX + 1;
					_15.y = y;
					var _16:Boolean = _11.indexOf(_13) != -1;
					var _17:Number;
					if(_16){
						if(_12-- > 1){
							if(_15.scrollRect == null || stage == null){
								_17 = _15.height;
							}else{
								var _18:Transform = _15.transform;
								if(stage.scaleMode == StageScaleMode.NO_SCALE){
									_17 = _18.pixelBounds.height;
								}else{
									var _19:Matrix = _18.matrix;
									var _20:Matrix = _18.concatenatedMatrix;
									_20.invert();
									_18.matrix = _20;
									_17 = _18.pixelBounds.height;
									_18.matrix = _19;
								}
							}
							_17 = Math.min(_17,_10);
						}else{
							_17 = _10;
						}
					}else{
						_17 = 0;
					}
					_15.scrollRect = new Rectangle(0,0,_5-2,_17);
					if(!_16){
						_15.visible = false;
						continue;
					}
					_15.visible = true;
					y += _17;
					_10 = Math.max(0, _10-_17);
				}
				return;
			}
			var _21:Array = [];
			var _22:Number = 0;
			for (_13 = 0; _13<_7; _13++) {
				_15 = _items[_13];
				_16 = _11.indexOf(_13) != -1;
				if(_16){
					if(_12-- > 1){
						if(_15.scrollRect == null || stage == null){
							_17 = _15.height;
						}else{
							_18 = _15.transform;
							if(stage.scaleMode == StageScaleMode.NO_SCALE){
								_17 = _18.pixelBounds.height;
							}else{
								_19 = _18.matrix;
								_20 = _18.concatenatedMatrix;
								_20.invert();
								_18.matrix = _20;
								_17 = _18.pixelBounds.height;
								_18.matrix = _19;
							}
						}
						_17 = Math.min(_17,_10);
					}else{
						_17 = _10;
					}
				}else{
					_17 = 0;
				}
				var _23:Rectangle = _15.scrollRect;
				if(_23 != null){
					if(!_15.visible && (_23.height != 0 || _16)){
						_15.visible = true;
					}
					_21.push(_17 - _23.height);
					_22 = Math.max(_22, Math.abs(_17 - _23.height));
				}else{
					_21.push(_17);
				}
				_10 = Math.max(0, _10-_17);
			}
			if(_22 == 0){
				return;
			}
			if(_9 == null){
				_9 = tween = new Tween(this,_21.toString(),null,_22,0,0.1,true);
				_9.addEventListener(TweenEvent.MOTION_CHANGE,function(evt:TweenEvent){
					var _9:Tween = Tween(evt.currentTarget);
					var _25:Accordion = Accordion(_9.obj);
					var _7:uint = _25.getLength();
					var _6:Number = _25._height;
					_6 -=  _25._contentPaddingY * 2 + 1;
					var _10:Number = _6 - _25.header.height * _7;
					var _11:Array = _25.getSelectedIndices();
					var _12:uint = _11.length;
					var _21:Array = _9.prop.split(",");
					var y = _25._contentPaddingY;
					for (var _13:int = 0; _13<_7; _13++) {
						var _14:DisplayObject = _25._headers[_13];
						_14.y = y;
						y += _14.height;
						var _15:DisplayObject = _25._items[_13];
						var _35:Number = Number(_21[_13]);
						if(!_15.visible){
							continue;
						}
						_15.y = y;
						_35 = _9.func(_9.time,_35,0-_35,_9.duration);
						var _16:Boolean = _11.indexOf(_13) != -1;
						var _17:Number;
						if(_16){
							if(_12-- > 1){
								if(_15.scrollRect == null || _15.stage == null){
									_17 = _15.height;
								}else{
									var _18:Transform = _15.transform;
									if(_15.stage.scaleMode == StageScaleMode.NO_SCALE){
										_17 = _18.pixelBounds.height;
									}else{
										var _19:Matrix = _18.matrix;
										var _20:Matrix = _18.concatenatedMatrix;
										_20.invert();
										_18.matrix = _20;
										_17 = _18.pixelBounds.height;
										_18.matrix = _19;
									}
								}
								_17 = Math.min(_17,_10);
							}else{
								_17 = _10;
							}
						}else{
							_17 = 0;
						}
						var _23:Rectangle = _15.scrollRect;
						_23.height = _17 - _35;
						if(_17 == 0 && _23.height <= 0){
							_15.visible = false;
						}
						_15.scrollRect = _23;
						y += _23.height;
						_10 = Math.max(0, _10-_17);
					}
					evt.updateAfterEvent();
				});
			}else{
				_9.prop = _21.toString();
				_9.begin = _22;
				_9.finish = 0;
				_9.start();
			}
		}
	}
}

package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import shinater.swing.managers.PopUpManager;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class Menu extends MenuItem {
		private var _1:Array = [];
		private var _2:Array = [];
		private var _3:Number = -1;
		private var _4:Component;
		protected var _contentPaddingX:Number = 3;
		protected var _contentPaddingY:Number = 3;
		
		public var delay:Number = 250;
		private var _5:Number;
		
		public var separatorSkin:Sprite;
				
		public function Menu(label:String = null) {
			super();
			if(label != null){
				setLabel(label);
			}
		}
		protected override function init():void {
			_contentPaddingX = _contentPaddingY = separatorSkin.x;
			removeChild(separatorSkin);
			buttonMode = false;
			focusRect = false;
			visible = false;
			addEventListener("hide",onHide,false,0,true);
			addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
		}
		public override function getAutoSize():Boolean{
			return true;
		}
		public override function get width():Number{
			return super.width;
		}
		public override function get height():Number{
			return super.height;
		}
		public override function get tabEnabled():Boolean {
			return false;
		}
		public override function get tabChildren():Boolean {
			return false;
		}
		public override function getFocusEnabled():Boolean {
			return true;
		}
		public override function setMouseState(state:String):void {
		}
		
		public function addMenuItem(menuItem:MenuItem):void {
			addMenuItemAt(menuItem,getMenuItemCount());
		}
		
		public function addMenuItemAt(menuItem:MenuItem,index:uint):void {
			var _6:int = _1.length == 0 ? numChildren : (index < _1.length ? getChildIndex(_2[index]) : getChildIndex(_2[_1.length-1])+1);
			var _7:MenuItem = menuItem;
			if (menuItem is Menu) {
				_7 = createMenuItem(menuItem.getLabel(),menuItem.getMnemonic(),menuItem.getIcon());
				addChild(menuItem);
			}else{
				_7.addEventListener(MouseEvent.MOUSE_UP,onMenuItemUp,false,1,true);
			}
			_7.addEventListener(MouseEvent.ROLL_OVER,onMenuItemOver,false,1,true);
			_7.addEventListener(MouseEvent.ROLL_OUT,onMenuItemOut,false,1,true);
			addChildAt(_7,_6);
			_2.splice(index,0,_7);
			_1.splice(index,0,menuItem);
		}
		
		public function getMenuItemAt(index:uint):MenuItem {
			var _6:Object = _1[index];
			if (_6 is MenuItem) {
				return MenuItem(_6);
			}
			return null;
		}
		
		public function getMenuItemCount():Number {
			return _1.length;
		}
		
		public function addSeparator():void {
			_1.push("separator");
			var _6:DisplayObject = _2.indexOf(separatorSkin) == -1 ? separatorSkin : createSeparator();
			addChildAt(_6, _2.length == 0 ? numChildren : getChildIndex(_2[_2.length - 1])+1);
			_2.push(_6);
		}
		
		public function removeAll():void {
			for (var _6:int = _1.length - 1; _6 >= 0; _6--) {
				var _7:DisplayObject = _2[_6];
				if (_7 is MenuItem) {
					_7.removeEventListener(MouseEvent.ROLL_OVER,onMenuItemOver);
					_7.removeEventListener(MouseEvent.ROLL_OUT,onMenuItemOut);
					_7.removeEventListener(MouseEvent.MOUSE_UP,onMenuItemUp);
				}
				removeChild(_7);
				var _8:Object = _1[_6];
				if (_8 is Menu) {
					removeChild(Menu(_8));
				}
			}
			_2.splice(0);
			_1.splice(0);
		}
		
		public function removeMenuItem(menuItem:MenuItem):MenuItem {
			var _6:int = _1.indexOf(menuItem);
			if (_6 == -1) {
				return null;
			}
			return removeMenuItemAt(_6);
		}
		
		public function removeMenuItemAt(index:Number):MenuItem {
			var _6:DisplayObject = _2[index];
			if (_6 is MenuItem) {
				_6.removeEventListener(MouseEvent.ROLL_OVER,onMenuItemOver);
				_6.removeEventListener(MouseEvent.ROLL_OUT,onMenuItemOut);
				_6.removeEventListener(MouseEvent.MOUSE_UP,onMenuItemUp);
			}
			removeChild(_6);
			_2.splice(index,1);
			var _7:Object = _1[index];
			if (_7 is Menu) {
				removeChild(Menu(_7));
			}
			_1.splice(index,1);
			if (_7 is MenuItem) {
				return MenuItem(_7);
			}
			return null;
		}
		public function setSelectedIndex(index:int):void {
			if (_3 == index) {
				return;
			}
			if(index != -1 && !(_1[index] is MenuItem)){
				return;
			}
			if (_3 != -1) {
				_2[_3].setMouseState("up");
			}
			_3 = index;
			if (index != -1) {
				_2[index].setMouseState("over");
			}
		}
		public function getSelectedIndex():int {
			return _3;
		}
		
		public function setInvoker(invoker:Component):void {
			_4 = invoker;
		}
		
		public function getInvoker():Component {
			return _4;
		}
		
		[Event(name = "show",type = "flash.events.Event")]
		
		[Event(name = "hide",type = "flash.events.Event")]
		
		public function show(invoker:Component,x:Number,y:Number):void {
			_4 = invoker;
			repaint();
			PopUpManager.show(this,invoker,x,y);
		}
		
		public function hide():void {
			PopUpManager.hide(this);
		}
		protected function showSubMenu(menu:Menu):void {
			menu.repaint();
			var _6:int = _1.indexOf(menu);
			var _7:MenuItem = _2[_3];
						var _8:Point = new Point(_7.x + _7.width - _contentPaddingX, Math.max(0,_7.y - _contentPaddingY));
			_8 = localToGlobal(_8);
			if(_8.x + menu.width > stage.stageWidth){
				_8.x = Math.max(0,_8.x - _7.width + _contentPaddingX*2 - menu.width);
			}
			if(_8.y + menu.height > stage.stageHeight){
				_8.y = Math.max(0,_8.y + _contentPaddingY*2 + _7.height - menu.height);
			}
			_8 = globalToLocal(_8);
			menu.setLocation(_8.x, _8.y);
			menu.visible = true;
			menu.setFocus();
					}
		protected function hideSubMenu(menu:Menu):void {
			clearTimeout(_5);
			if(menu.visible){
				menu.setSelectedIndex(-1);
				menu.visible = false;
				setFocus();
			}
		}
		protected function createMenuItem(label:String,mnemonic:String,icon:DisplayObject):MenuItem {
			var _6:MenuItem = new MenuItem();
			_6.setLabel(label);
			_6.setMnemonic(mnemonic);
			_6.setIcon(icon);
			return _6;
		}
		protected function createSeparator():DisplayObject {
			var _6:Class = separatorSkin["constructor"] as Class;
			var _7:DisplayObject = new _6() as DisplayObject;
			return _7;
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		protected function onMenuItemOver(evt:MouseEvent):void {
			var _6:int = _2.indexOf(evt.currentTarget);
			if(_6 == _3){
				evt.stopImmediatePropagation();
				return;
			}
			if(_3 != -1){
				var _7:MenuItem = _1[_3];
				if(_7 is Menu){
					hideSubMenu(Menu(_7));
				}
				setSelectedIndex(-1);
			}
			_3 = _6;
			var _8:MenuItem = _1[_6];
			if(_8 is Menu){
				
								clearTimeout(_5);
				_5 = setTimeout(showSubMenu,delay,Menu(_8));
			}
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected function onMenuItemOut(evt:MouseEvent):void {
			var _6:int = _2.indexOf(evt.currentTarget);
			var _7:MenuItem = _1[_6];
			if(_7 is Menu){
				if(_7.hitTestPoint(evt.stageX,evt.stageY,true)){
					evt.stopImmediatePropagation();
					return;
				}
				hideSubMenu(Menu(_7));
			}
			_3 = -1;
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected function onMenuItemUp(evt:MouseEvent):void{
			var _6:Menu = this;
			while(_6.parent is Menu){
				_6 = Menu(_6.parent);
			}
			_6.hide();
		}
		protected function onHide(evt:Event):void{
						if (_3 != -1) {
				var _6:MenuItem = _1[_3];
				if (_6 is Menu) {
					hideSubMenu(Menu(_6));
				}
				_2[_3].setMouseState("up");
				_3 = -1;
			}
		}
		protected override function onKeyDown(evt:KeyboardEvent):void {
						var _6:uint = getMenuItemCount();
			if (_6 == 0) {
				return;
			}
			if (evt.keyCode == Keyboard.UP) {
				var _7:int = _3 <= 0 ? _6 - 1:_3 - 1;
				do {
					if (_1[_7] is MenuItem) {
						setSelectedIndex(_7);
						dispatchEvent(new Event(Event.CHANGE,false));
						break;
					}
					_7 = _7 == 0 ? _6 - 1:_7 - 1;
				} while (_7 != _3 && (_7 != _6 - 1 || _3 != -1));
			} else if (evt.keyCode == Keyboard.DOWN) {
				_7 = _3 == _6 - 1 ? 0:_3 + 1;
				do {
					if (_1[_7] is MenuItem) {
						setSelectedIndex(_7);
						dispatchEvent(new Event(Event.CHANGE,false));
						break;
					}
					_7 = _7 == _6 - 1 ? 0:_7 + 1;
				} while (_7 != _3 && (_7 != 0 || _3 != -1));
			} else if (evt.keyCode == Keyboard.LEFT || evt.keyCode == Keyboard.ESCAPE) {
				if(_3 == -1) {
					return;
				}
				var _8:MenuItem = getMenuItemAt(_3);
				if (!(_8 is Menu) || !_8.visible) {
					return;
				}
				var _9:Menu = Menu(_8);
				hideSubMenu(_9);
			} else if (evt.keyCode == Keyboard.RIGHT) {
				if(_3 == -1) {
					return;
				}
				_8 = getMenuItemAt(_3);
				if (!(_8 is Menu) || !_2[_3].getEnabled() || _8.visible) {
					return;
				}
				
				_9 = Menu(_8);
				showSubMenu(_9);
				_9.setSelectedIndex(0);
			} else if (evt.keyCode == Keyboard.ENTER ) {
				if(_3 == -1) {
					return;
				}
				_8 = getMenuItemAt(_3);
				if(_8 is Menu){
					_9 = Menu(_8);
					if(!_2[_3].getEnabled() || _9.visible){
						return;
					}
					
					showSubMenu(_9);
					_9.setSelectedIndex(0);
				}else if(_8.getEnabled()){
					_8.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,false,0,0,null,evt.ctrlKey,evt.altKey,evt.shiftKey,false));
					_8.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,false,0,0,null,evt.ctrlKey,evt.altKey,evt.shiftKey,false));
					_8.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,evt.ctrlKey,evt.altKey,evt.shiftKey,false));
				}
			} else {
				_7 = _3;
				var _10:int = -1;
				var _11:Boolean = false;
				var _12:String = String.fromCharCode(evt.charCode).toUpperCase();
				while(true){
					_7 = _7 == _6 - 1 ? 0 : _7 + 1;
					if(_1[_7] is MenuItem){
						_8 = _1[_7];
						if (_8 is Menu) {
							_8 = _2[_7];
						}
						if(_8.getEnabled()){
							var _13:String = _8.getMnemonic();
							if(_13 != null && _13.toUpperCase() == _12){
								if(_10 == -1){
									_10 = _7;
								}else{
									_11 = true;
									break;
								}
							}
						}
						if(_7 == _3 || (_7 == _6 - 1 && _3 == -1)){
							break;
						}
					}
				}
				if(_10 == -1){
					if(parent is Menu){
						evt.stopPropagation();
					}
					return;
				}
				setSelectedIndex(_10);
				dispatchEvent(new Event(Event.CHANGE,false));
				if(!_11){
					_8 = _1[_10];
					if(_8 is Menu){
						
						_9 = Menu(_8);
						showSubMenu(_9);
						_9.setSelectedIndex(0);
					}else{
						_8.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true,false,0,0,null,evt.ctrlKey,evt.altKey,evt.shiftKey,false));
						_8.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true,false,0,0,null,evt.ctrlKey,evt.altKey,evt.shiftKey,false));
						_8.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false,0,0,null,evt.ctrlKey,evt.altKey,evt.shiftKey,false));
					}
				}
			}
			evt.stopPropagation();
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callDeclaredMethod(this,"repaint")){
				return;
			}
			var _6:Number = 0;
			for (var _7:int = 0,_8:uint = _1.length; _7 < _8; _7++) {
				if (! (_1[_7] is MenuItem)) {
					continue;
				}
				var _9:MenuItem = _2[_7];
				_9.setAutoSize(true);
				var _10:MenuItem = _1[_7];
				if (_10 is Menu) {
					_9.setMnemonic(_10.getMnemonic());
					_9.setIcon(_10.getIcon());
					_9.setLabel(_10.getLabel());
				} else {
					if(_9.arrowSkin != null){
						_9.arrowSkin.visible = false;
					}
					_9.repaint();
				}
				_6 = Math.max(_6,_9.getWidth());
			}
			var _11:Number = _contentPaddingY;
			for (_7 = 0,_8 = _2.length; _7 < _8; _7++) {
				var _12:DisplayObject = _2[_7];
				_12.x = _contentPaddingX;
				if (_12 is MenuItem) {
					MenuItem(_12).setAutoSize(false);
					_12.y = _11;
					_11 +=  _12.height;
				} else {
					_12.y = _11 + _contentPaddingY;
					_11 +=  _12.height + _contentPaddingY * 2;
				}
				_12.width = _6;
			}
			if (_6 > 0) {
				skin.width = _6 + _contentPaddingX * 2;
			}
			skin.height = _11 + _contentPaddingY;
		}
	}
}

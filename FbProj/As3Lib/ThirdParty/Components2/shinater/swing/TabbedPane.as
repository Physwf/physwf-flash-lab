package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Rectangle;
	import shinater.swing.managers.FocusManager;
	import shinater.swing.managers.StyleManager;
	
	
	public dynamic class TabbedPane extends Container {
		private var _1:int = -1;
		private var _2:int = -1;
		protected var _tabComponents:Array = [];
		protected var _pages:Array = [];
		protected var _width:Number;
		protected var _height:Number;
		protected var _tabBarHeight:Number;
		protected var _tabBarPaddingX:Number = 0;
		protected var _tabBarPaddingY:Number = 0;
		protected var _contentPaddingX:Number = 1;
		protected var _contentPaddingY:Number = 1;
		
		public var skin:Sprite;
				
		public var tabButton:ToggleButton;
		
		public function TabbedPane() {
			super();
		}
		protected override function init():void {
			_width = super.width;
			_height = super.height;
			scaleX = scaleY = 1;
			super.init();
			_tabBarHeight = skin.y;
			_tabBarPaddingX = tabButton.x;
			_tabBarPaddingY = tabButton.y;
			tabButton.setAutoSize(true);
						tabButton.tabEnabled = false;
			removeChild(tabButton);
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
			if(getTabCount() == 0){
				return false;
			}
			return super.getFocusEnabled();
		}
		public override function setFocus():void {
			if(!getFocusEnabled()) {
				return;
			}
			FocusManager.setFocus(_tabComponents[_2 != -1 ? _2 : 0]);
		}
		public override function drawFocus(focused:Boolean):void {
			if(getTabCount() == 0){
				return;
			}
			_tabComponents[_2 != -1 ? _2 : 0].drawFocus(focused);
		}
		
		public function addTab(component:DisplayObject,title:String, icon:DisplayObject = null):void {
			addTabAt(component,title,getTabCount(),icon);
		}
		
		public function addTabAt(component:DisplayObject,title:String, index:uint, icon:DisplayObject = null):void {
			var _3:ToggleButton;
			if (index == 0) {
				_3 = tabButton;
				if (_tabComponents.length > 0 && _tabComponents[0] == tabButton) {
					var _4:ToggleButton = createTabComponent(tabButton.getLabel(),tabButton.getIcon());
					_4.setEnabled(tabButton.getEnabled());
					_4.setSelected(tabButton.getSelected());
					_4.addEventListener(MouseEvent.CLICK,onTabComponentClick,false,0,true);
					addChildAt(_4, getChildIndex(tabButton) + 1);
					_tabComponents[0] = _4;
				}else{
					_3.addEventListener(MouseEvent.CLICK,onTabComponentClick,false,0,true);
					addChildAt(_3,1);
				}
				_3.setLabel(title);
				_3.setIcon(icon);
				_3.setEnabled(true);
				_3.setSelected(false);
				addChildAt(component, getChildIndex(_3)+1);
			} else {
				_3 = createTabComponent(title,icon);
				_3.addEventListener(MouseEvent.CLICK,onTabComponentClick,false,0,true);
				var _5:uint = index < _pages.length ? getChildIndex(_tabComponents[index]):numChildren;
				addChildAt(_3,_5);
				addChildAt(component, _5+1);
			}
			_tabComponents.splice(index,0,_3);
			_pages.splice(index,0,component);
			if (_pages.length == 1) {
				setSelectedIndex(0);
				return;
			}
			if (_1 >= index) {
				_1++;
			}
			if (_2 >= index) {
				_2++;
			}
			repaint();
		}
		
		public function getComponentAt(index:uint):DisplayObject {
			return _pages[index];
		}
		
		
		public function getTabCount():uint {
			return _pages.length;
		}
		
		public function removeAll():void {
			for (var _3:int = _pages.length - 1; _3 >= 0; _3--) {
				var _4:ToggleButton = _tabComponents[_3];
				_4.removeEventListener(MouseEvent.CLICK, onTabComponentClick);
				removeChild(_4);
				var _5:DisplayObject = _pages[_3];
				removeChild(_5);
				_5.visible = true;
			}
			_tabComponents.splice(0);
			_pages.splice(0);
			_1 = _2 = -1;
			repaint();
		}
		
		public function removeTabAt(index:uint):DisplayObject {
			var _3:ToggleButton = _tabComponents[index];
			_3.removeEventListener(MouseEvent.CLICK, onTabComponentClick);
			removeChild(_3);
			_tabComponents.splice(index,1);
			var _4:DisplayObject = _pages[index];
			removeChild(_4);
			_4.visible = true;
			_pages.splice(index,1);
			if (_1 == index) {
				_1 = -1;
				if(_pages.length > 0){
					setSelectedIndex(Math.min(index,_pages.length-1));
					return _4;
				}
			}
			if (_1 > index) {
				_1--;
			}
			if (_2 == index) {
				_2 = -1;
			} else if (_2 > index) {
				_2--;
			}
			repaint();
			return _4;
		}
		
		public function setTitleAt(title:String,index:uint):void {
			if(index >= _pages.length){
				throw new RangeError();
			}
			_tabComponents[index].setLabel(title);
		}
		
		public function getTitleAt(index:uint):String {
			if(index >= _pages.length){
				throw new RangeError();
			}
			return _tabComponents[index].getLabel();
		}
		
		public function setIconAt(icon:DisplayObject,index:uint):void {
			if(index >= _pages.length){
				throw new RangeError();
			}
			_tabComponents[index].setIcon(icon);
		}
		
		public function getIconAt(index:uint):DisplayObject {
			if(index >= _pages.length){
				throw new RangeError();
			}
			return _tabComponents[index].getIcon();
		}
		
		public function setEnabledAt(enabled:Boolean,index:uint):void {
			if(index >= _pages.length){
				throw new RangeError();
			}
			if(!enabled && _2 == index){
				_tabComponents[index].drawFocus(false);
			}
			_tabComponents[index].setEnabled(enabled);
		}
		
		public function getEnabledAt(index:uint):Boolean {
			if(index >= _pages.length){
				throw new RangeError();
			}
			return _tabComponents[index].getEnabled();
		}
		
		public function setSelectedIndex(index:int):void {
			if (_1 == index) {
				return;
			}
			if (_1 != -1) {
				_tabComponents[_1].setSelected(false);
							}
			_1 = index;
			if (_1 != -1) {
				_2 = index;
				_tabComponents[index].setSelected(true);
							}
			repaint();
		}
		
		public function getSelectedIndex():int {
			return _1;
		}
		
		public function setSelectedComponent(component:DisplayObject):void {
			var _3:int = _pages.indexOf(component);
			if (_3 == -1) {
				return;
			}
			setSelectedIndex(_3);
		}
		
		public function getSelectedComponent():DisplayObject {
			if (_1 == -1) {
				return null;
			}
			return _pages[_1];
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		
		
		
		protected function createTabComponent(title:String, icon:DisplayObject):ToggleButton {
			var _3:Class = tabButton["constructor"] as Class;
			var _4:ToggleButton = new _3() as ToggleButton;
			_4.setLabel(title);
			_4.setIcon(icon);
			_4.setAutoSize(true);
						_4.tabEnabled = false;
			return _4;
		}
		protected function onTabComponentClick(evt:MouseEvent):void {
			var _3:Number = _tabComponents.indexOf(evt.currentTarget);
			var _4:ToggleButton = ToggleButton(evt.currentTarget);
			if(!_4.getSelected()){
				_4.setSelected(true);
				return;
			}
			setSelectedIndex(_3);
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected function onKeyDown(evt:KeyboardEvent):void {
			var _3:uint = getTabCount();
			if (_3 == 0) {
				return;
			}
			var _4:int = -1;
			if (evt.keyCode == Keyboard.LEFT) {
				for(var _5:int = _3-1; _5>=0; _5--){
					if(_tabComponents[_5].getEnabled()){
						_4 = _5;
						if(_4 < _2){
							break;
						}
					}
				}
				_2 = _4;
				if(_2 != -1){
					FocusManager.setFocus(_tabComponents[_2]);
					_tabComponents[_2].drawFocus(true);
				}
			} else if (evt.keyCode == Keyboard.RIGHT) {
				for(_5 = 0; _5<_3; _5++){
					if(_tabComponents[_5].getEnabled()){
						_4 = _5;
						if(_4 > _2){
							break;
						}
					}
				}
				_2 = _4;
				if(_2 != -1){
					FocusManager.setFocus(_tabComponents[_2]);
					_tabComponents[_2].drawFocus(true);
				}
			} else if ((evt.keyCode == Keyboard.ENTER ) && _2 != -1) {
				var _6:ToggleButton = _tabComponents[_2];
				if(!_6.getEnabled() || _6.getSelected()){
					return;
				}
				setSelectedIndex(_2);
				evt.stopPropagation();
				dispatchEvent(new Event(Event.CHANGE,false));
			}
		}
		public override function repaint():void {
						if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _3:Number = _width;
			var _4:Number = _height;
			var _5:uint = getTabCount();
			if(_5 == 0){
				skin.y = 0;
				skin.width = _3;
				skin.height = _4;
				scrollRect = null;
			}else{
				var _6:Number = _tabBarPaddingX;
				for (var _7:int = 0; _7<_5; _7++) {
					var _8:DisplayObject = _tabComponents[_7];
					_8.x = _6;
					_8.y = _tabBarPaddingY;
					var _9:Rectangle = _8.getBounds(_8);
					_6 += _9.width + _9.x*2;
					var _10:DisplayObject = _pages[_7];
					if(_7 == _1){
						_10.x = _contentPaddingX;
						_10.y = _tabBarHeight + _contentPaddingY;
						_10.width = _3 - _contentPaddingX*2;
						_10.height = _4 - _tabBarHeight - _contentPaddingY*2;
						_10.visible = true;
					}else{
						_10.visible = false;
					}
				}
				skin.y = _tabBarHeight;
				skin.width = _3;
				skin.height = _4 - skin.y;
				if(super.width > _3 || super.height > _4 || scrollRect != null){
					scrollRect = new Rectangle(0,0,_3,_4);
				}
			}
		}
	}
}

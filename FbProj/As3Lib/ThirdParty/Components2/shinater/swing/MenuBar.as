package shinater.swing{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import shinater.swing.managers.WindowManager;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class MenuBar extends Component {
		private var _1:Number = -1;
		protected var _labelButtons:Array = [];
		protected var _menus:Array = [];
		protected var _width:Number;
		protected var _height:Number;
		protected var _contentPaddingX:Number = 0;
		protected var _contentPaddingY:Number = 0;
		
		public var labelButton:Button;
		
		public var skin:Sprite;
				
		public function MenuBar() {
			super();
		}
		protected override function init():void {
			_width = super.width;
			_height = super.height;
			scaleX = scaleY = 1;
			super.init();
			_contentPaddingX = labelButton.x;
			_contentPaddingY = labelButton.y;
			labelButton.setAutoSize(true);
			labelButton.setFocusEnabled(false);
						removeChild(labelButton);
			
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage,false,0,true);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage,false,0,true);
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
		public override function get tabEnabled():Boolean {
			return false;
		}
		public override function get tabChildren():Boolean {
			return false;
		}
		
		public function addMenu(menu:Menu,label:String=null):void {
			if (label != null) {
				menu.setLabel(label);
			}
			addMenuAt(menu,getMenuCount());
		}
		
		public function addMenuAt(menu:Menu,index:uint):void {
			var _2:Button;
			var _3:String = menu.getLabel();
			var _4:String = menu.getMnemonic();
			if (_3 != null && _4 != null) {
				var _5:String = _3.toUpperCase();
				var _6:String = _4.toUpperCase()
				var _7:int = _5.indexOf(_6);
				if(_7 != -1){
					if(_5.indexOf("(" + _6 + ")") == -1){
						_3 = _3.substring(0,_7) + "<U>" + _3.charAt(_7) + "</U>" + _3.substr(_7 + 1);
					}
				}else{
					_3 += "(" + _4 + ")";
				}
			}
			if (index == 0) {
				_2 = labelButton;
				if (_labelButtons.length > 0 && _labelButtons[0] == labelButton) {
					var _8:Button = createLabelButton(labelButton.getLabel());
					_8.addEventListener(MouseEvent.MOUSE_DOWN,onLabelButtonDown,false,0,true);
					addChildAt(_8,getChildIndex(labelButton) + 1);
					_labelButtons[0] = _8;
				}else{
					_2.addEventListener(MouseEvent.MOUSE_DOWN,onLabelButtonDown,false,0,true);
					addChildAt(_2,1);
				}
				_2.setLabel(_3);
			} else {
				_2 = createLabelButton(_3);
				_2.addEventListener(MouseEvent.MOUSE_DOWN,onLabelButtonDown,false,0,true);
				var _9:uint = index < _labelButtons.length ? getChildIndex(_labelButtons[index]):numChildren;
				addChildAt(_2,_9);
			}
			_labelButtons.splice(index,0,_2);
						menu.addEventListener("show",onMenuShow,false,0,true);
			menu.addEventListener("hide",onMenuHide,false,0,true);
			_menus.splice(index,0,menu);
			if (_1 >= index) {
				_1++;
			}
			repaint();
		}
		
		public function getMenuAt(index:uint):Menu {
			return _menus[index];
		}
		
		public function getMenuCount():uint {
			return _menus.length;
		}
		
		public function removeMenuAt(index:uint):Menu {
			var _2:Button = _labelButtons[index];
			_2.removeEventListener(MouseEvent.MOUSE_DOWN,onLabelButtonDown);
			removeChild(_2);
			_labelButtons.splice(index,1);
			var _3:Menu = _menus[index];
			_3.removeEventListener("show",onMenuShow);
			_3.removeEventListener("hide",onMenuHide);
			if (_3.parent != null) {
				_3.parent.removeChild(_3);
			}
			_menus.splice(index,1);
			if (_1 == index) {
				_1 = -1;
			} else if (_1 > index) {
				_1--;
			}
			repaint();
			return _3;
		}
		
		public function removeAll():void {
			for (var _2:int = _menus.length - 1; _2 >= 0; _2--) {
				var _3:Button = _labelButtons[_2];
				_3.removeEventListener(MouseEvent.MOUSE_DOWN,onLabelButtonDown);
				removeChild(_3);
				var _4:Menu = _menus[_2];
				_4.removeEventListener("show",onMenuShow);
				_4.removeEventListener("hide",onMenuHide);
				if (_4.parent != null) {
					_4.parent.removeChild(_4);
				}
			}
			_labelButtons.splice(0);
			_menus.splice(0);
			_1 = -1;
			repaint();
		}
		
		public function setSelectedIndex(index:int):void {
			if (_1 == index) {
				return;
			}
			if (_1 != -1) {
				var _2:Button = _labelButtons[_1];
				if (_2.getEnabled()) {
					_menus[_1].hide();
					_2.setMouseState("up");
				}
			}
			_1 = index;
			if (_1 != -1) {
				_2 = _labelButtons[index];
				if (_2.getEnabled()) {
					_2.setMouseState("down");
					_2.mouseEnabled = false;
										_menus[index].show(this,_2.x,_2.y + _2.height);
				}
			}
		}
		
		public function getSelectedIndex():int {
			return _1;
		}
		protected function onAddedToStage(evt:Event):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
		}
		protected function onRemovedFromStage(evt:Event):void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		protected function createLabelButton(label:String):Button {
			var _2:Class = labelButton["constructor"] as Class;
			var _3:Button = new _2() as Button;
			_3.setAutoSize(true);
			_3.setLabel(label);
			_3.setFocusEnabled(false);
			return _3;
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		protected function onLabelButtonDown(evt:MouseEvent):void {
			var _2:int = _labelButtons.indexOf(evt.currentTarget);
			var _3:Menu = _menus[_2];
			var _4:Button = Button(evt.currentTarget);
			_4.mouseEnabled = false;
			_3.show(this,_4.x,_4.y + _4.height);
			_1 = _2;
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		
		protected function onMenuShow(evt:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove,false,0,true);
		}
		protected function onMenuHide(evt:Event):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			var _2:Button = _labelButtons[_1];
			_2.mouseEnabled = true;
			_1 = -1;
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected function onMouseMove(evt:MouseEvent):void {
			for(var _2:int = 0,_3:uint = _labelButtons.length; _2<_3; _2++){
				if(_2 == _1 || !_labelButtons[_2].hitTestPoint(evt.stageX,evt.stageY,true)){
					continue;
				}
				setSelectedIndex(_2);
				dispatchEvent(new Event(Event.CHANGE,false));
				return;
			}
		}
		protected function onKeyDown(evt:KeyboardEvent):void {
						if (stage.focus is TextField) {
				return;
			}
			var _2:Window = WindowManager.getActiveWindow();
			if(_2 != null && !_2.contains(this)){
				return;
			}
			var _3:uint = getMenuCount();
			if (_3 == 0) {
				return;
			}
			var _4:Menu;
			if (evt.keyCode == Keyboard.LEFT || evt.keyCode == Keyboard.RIGHT) {
				if (_3 < 2 || _1 == -1) {
					return;
				}
				var _5:int;
				if (evt.keyCode == Keyboard.LEFT) {
					_5 = _1 > 0 ? _1 - 1:_3 - 1;
				}else{
					_5 = _1 == _3 - 1 ? 0:_1 + 1;
				}
				setSelectedIndex(_5);
				_4 = getMenuAt(_5);
				if (_4.getEnabled()) {
					_4.setSelectedIndex(0);
				}
			} else {
				_5 = -1;
				var _6:String = String.fromCharCode(evt.charCode).toUpperCase();
				for (var _7:int = 0; _7 < _3; _7++) {
					if (_labelButtons[_7].getEnabled()) {
						_4 = getMenuAt(_7);
						var _8:String = _4.getMnemonic();
						if (_8 != null && _8.toUpperCase() == _6) {
							_5 = _7;
							break;
						}
					}
				}
				if (_5 == -1) {
					return;
				}
				if (_1 == -1) {
					setSelectedIndex(_5);
					_4.setSelectedIndex(0);
				} else if (_1 == _5) {
					setSelectedIndex(-1);
				} else {
					return;
				}
			}
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _2:Number = _width;
			var _3:Number = _height;
			if(skin != null){
				skin.width = _2;
				skin.height = _3;
			}
			var _4:Number = _contentPaddingX;
			for (var _5:int = 0,_6:uint = getMenuCount(); _5 < _6; _5++) {
				var _7:Button = _labelButtons[_5];
				_7.setEnabled(getMenuAt(_5).getEnabled());
				_7.x = _4;
				_7.y = _contentPaddingY;
				_4 += _7.width;			}
			if(super.width > _2 || scrollRect != null){
				scrollRect = new Rectangle(0,0,_2,_3);
			}
		}
	}
}

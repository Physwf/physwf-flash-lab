package shinater.swing{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public dynamic class Frame extends Window {
		private var _1:Rectangle;
		private var _2:Boolean = false;
		private var _3:Rectangle;
		protected var _maximizeButtonPadding:Number = 0;
		protected var _menuBarPaddingX:Number = 5;
		protected var _menuBarPaddingY:Number = 30;
		
		public var maximizeButton:ToggleButton;
		
		public var menuBar:MenuBar;
		
		public function Frame(title:String = null) {
			super();
			if(title != null){
				setTitle(title);
			}
		}
		protected override function init():void {
			if (menuBar != null) {
				_menuBarPaddingX = menuBar.x;
				_menuBarPaddingY = menuBar.y;
			}
			if (maximizeButton != null) {
				_maximizeButtonPadding = closeButton.x - maximizeButton.x - maximizeButton.width;
				maximizeButton.tabEnabled = false;
				maximizeButton.setFocusEnabled(false);
				maximizeButton.addEventListener(MouseEvent.CLICK,onMaximize,false,0,true);
			}
			super.init();
			if (titleBackgroundSkin != null) {
				titleBackgroundSkin.doubleClickEnabled = true;
				titleBackgroundSkin.addEventListener(MouseEvent.DOUBLE_CLICK,onTitleBarDoubleClick,false,0,true);
			}
			skin.doubleClickEnabled = true;
			skin.addEventListener(MouseEvent.DOUBLE_CLICK,onBorderDoubleClick,false,0,true);
			setResizable(true);
			super.visible = true;
		}
		public override function setModal(modal:Boolean):void {
		}
		
		public function setMenuBar(menuBar:MenuBar):void {
			if (this.menuBar != null) {
				this.removeChild(this.menuBar);
			}
			this.menuBar = menuBar;
			if (menuBar != null) {
				this.addChild(menuBar);
			}
			repaint();
		}
		
		public function getMenuBar():MenuBar {
			return menuBar;
		}
		public override function getDragBounds():Rectangle{
			if(super.getDragBounds() != null){
				return super.getDragBounds();
			}
			if (stage == null) {
				return null;
			}
			return new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
		}
		
		public function setMaximizedBounds(bounds:Rectangle):void {
			_3 = bounds;
		}
		
		public function getMaximizedBounds():Rectangle {
			if (_3 != null) {
				return _3;
			}
			if (stage == null) {
				return null;
			}
			return new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
		}
		protected function onMaximize(evt:MouseEvent):void {
			if (maximizeButton.getSelected()) {
				if (_1 == null) {
					_1 = new Rectangle(x,y,_width,_height);
				}
				var _4:Rectangle = getMaximizedBounds();
				setLocation(_4.x,_4.y);
				setSize(_4.width,_4.height);
				_2 = true;
			} else {
				setSize(_1.width,_1.height);
				setLocation(_1.x,_1.y);
				_1 = null;
				_2 = false;
			}
		}
		protected function onTitleBarDoubleClick(evt:MouseEvent):void {
			if(getResizable() && !_2){
				var _4:Number = skin.width;
				var _5:Number = skin.height;
				var _6:Number = mouseX;
				var _7:Number = mouseY;
				if(_6 > _contentPaddingLeft && _6 < _4 - _contentPaddingLeft){
					if((_7 >= 0 && _7 <= _contentPaddingLeft) || (_7 >= _5 - _contentPaddingLeft && _7 <= _5)){
						onBorderDoubleClick(evt);
						return;
					}
				}
			}
			if (maximizeButton == null || ! maximizeButton.enabled) {
				return;
			}
			maximizeButton.setSelected(!_2);
			onMaximize(evt);
		}
		protected override function onDragMove(evt:MouseEvent):void {
			if (_1 != null) {
				if (! _2) {
					height = _1.height;
					_1 = null;
				} else {
					if (maximizeButton != null) {
						maximizeButton.setSelected(false);
					}
					var _4:Number = mouseX;
					var _5:Number = _width;
					var _6:Number = _1.width / 2;
					if (_4 > _6) {
						if (_4 > _5 - _6) {
							_4 = _5 - _1.width;
						} else {
							_4 = parent.mouseX - _6;
						}
						_4 = int(_4);
						this.x = _4;
						onDragStop(evt);
						onDragStart(evt);
					}
					setSize(_1.width,_1.height);
					_1 = null;
					_2 = false;
				}
			}
			super.onDragMove(evt);
		}
		protected override function onBorderOver(evt:MouseEvent):void {
			if(_2){
				return;
			}
			super.onBorderOver(evt);
		}
		protected override function onBorderScale(evt:MouseEvent):void {
			var _4:Number = _height;
			super.onBorderScale(evt);
			if(_1 != null && _4 != _height){
				_1 = null;
			}
		}
		protected function onBorderDoubleClick(evt:MouseEvent):void {
			
			if (! getResizable()) {
				return;
			}
			var _4:Number = skin.width;
			var _5:Number = skin.height;
			var _6:Number = mouseX;
			var _7:Number = mouseY;
			if(_6 > _contentPaddingLeft && _6 < _4 - _contentPaddingLeft){
				if((_7 >= 0 && _7 <= _contentPaddingLeft) || (_7 >= _5 - _contentPaddingLeft && _7 <= _5)){
					if (_1 == null) {
						_1 = new Rectangle(this.x,this.y,_width,_height);
						var _8:Rectangle = getMaximizedBounds();
						this.y = _8.y;
						this.height = _8.height;
					} else {
						this.y = _1.y;
						this.height = _1.height;
						_1 = null;
					}
				}
			}
		}
		public override function repaint():void {
			var _4:Number = _width;
			if (menuBar != null) {
				menuBar.x = _menuBarPaddingX;
				menuBar.y = _menuBarPaddingY;
				menuBar.width = _4 - _menuBarPaddingX*2;
			}
			super.repaint();
			if (maximizeButton != null) {
				maximizeButton.x = closeButton.x - _maximizeButtonPadding - maximizeButton.width;
				if (titleTextField != null) {
					titleTextField.width = maximizeButton.x - titleTextField.x;
				}
			}
		}
	}
}

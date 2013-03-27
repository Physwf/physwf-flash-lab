package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import shinater.swing.managers.WindowManager;
	import shinater.swing.managers.CursorManager;
	import shinater.swing.managers.StyleManager;

	
	public dynamic class Window extends Container {
		private var _1:String;
		private var _2:Window;
		private var _3:Boolean = false;
		private var _4:Rectangle;
		private var _5:Boolean = false;
		private var _6:Rectangle;
		private var _7:Rectangle;
		private var _8:Button;
		protected var _titleBarPaddingLeft:Number = 0;
		protected var _titleBarPaddingRight:Number = 0;
		protected var _contentPaddingLeft:Number = 0;
		protected var _contentPaddingRight:Number = 0;
		protected var _contentPaddingTop:Number = 0;
		protected var _contentPaddingBottom:Number = 0;
		protected var _width:Number;
		protected var _height:Number;
		
		private var _9:Point;
		private var _10:Point;
		private var _11:Rectangle;
		
		public var content:Panel;
		
		public var icon:DisplayObject;
		
		public var titleTextField:TextField;
		
		public var titleBackgroundSkin:Sprite;
				
		public var closeButton:Button;
		
		public var skin:Sprite;
				
		public function Window(title:String = null,modal:Boolean = false) {
			super();
			_1 = title;
			_3 = modal;
		}
		protected override function init():void {
			_width = super.width;
			_height = super.height;
			scaleX = scaleY = 1;
			super.init();
			var _12:Number = skin.width;
			var _13:Number = skin.height;
			if (icon != null) {
				_titleBarPaddingLeft = icon.x;
			} else if (titleTextField != null) {
				titleTextField.mouseEnabled = false;
				_titleBarPaddingLeft = titleTextField.x;
				_titleBarPaddingRight = _12 - titleTextField.x - titleTextField.width;
			}
			if (closeButton != null) {
				_titleBarPaddingRight = _12 - closeButton.x - closeButton.width;
			}
			_contentPaddingLeft = content.x;
						_contentPaddingRight = _contentPaddingLeft;
			_contentPaddingTop = content.y;
			_contentPaddingBottom = _13 - _contentPaddingTop - content.height;
			if (titleBackgroundSkin != null) {
				titleBackgroundSkin.addEventListener(MouseEvent.MOUSE_DOWN,onDragStart,false,0,true);
			}
			if (closeButton != null) {
				closeButton.tabEnabled = false;
				closeButton.setFocusEnabled(false);
				closeButton.addEventListener(MouseEvent.CLICK,onClose,false,0,true);
			}
			super.visible = false;
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
		public override function set enabled(value:Boolean):void{
			super.enabled = value;
			repaint();
		}
		
		[Event(name = "show",type = "flash.events.Event")]
		
		[Event(name = "hide",type = "flash.events.Event")]
		public override function set visible(value:Boolean):void {
			if (stage == null) {
				super.visible = value;
				if (value) {
					addEventListener(Event.ADDED_TO_STAGE,onAddedToStage,false,0,true);
				}
				return;
			}
			if (value) {
				if (!super.visible) {
					super.visible = true;
					WindowManager.activate(this);
					dispatchEvent(new Event("show"));
				} else if (WindowManager.getActiveWindow() != this) {
					WindowManager.activate(this);
				}
			} else if (super.visible) {
				super.visible = false;
				dispatchEvent(new Event("hide"));
				WindowManager.deactivate(this);
			}
		}
		
		public function setTitle(title:String):void {
			_1 = title;
			repaint();
		}
		
		public function getTitle():String {
			return _1;
		}
		
		public function setIcon(icon:DisplayObject):void {
			if (this.icon == icon) {
				return;
			}
			if (this.icon != null) {
				this.removeChild(this.icon);
			}
			this.icon = icon;
			if (icon != null) {
				this.addChild(icon);
			}
			repaint();
		}
		
		public function getIcon():DisplayObject {
			return icon;
		}
		
		public function setOwner(owner:Window):void {
			_2 = owner;
		}
		
		public function getOwner():Window {
			return _2;
		}
		
		public function setModal(modal:Boolean):void {
			_3 = modal;
		}
		
		public function getModal():Boolean {
			return _3;
		}
		
		public function setDefaultButton(defaultButton:Button):void {
			if(_8 == defaultButton){
				return;
			}
			if (_8 == null) {
				if (defaultButton != null) {
					addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
				}
			} else if (defaultButton == null) {
				removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
			_8 = defaultButton;
		}
		
		public function getDefaultButton():Button {
			return _8;
		}
		
		public function getContent():Panel {
			return content;
		}
		
		public function setDragBounds(bounds:Rectangle):void{
			_4 = bounds;
		}
		
		public function getDragBounds():Rectangle{
			return _4;
		}
		
		public function setResizable(resizable:Boolean):void {
			if (_5 == resizable) {
				return;
			}
			_5 = resizable;
			if (resizable) {
				if(titleBackgroundSkin != null){
					titleBackgroundSkin.mouseChildren = false;
					titleBackgroundSkin.addEventListener(MouseEvent.ROLL_OVER,onBorderOver,false,0,true);
					titleBackgroundSkin.addEventListener(MouseEvent.ROLL_OUT,onBorderOut,false,0,true);
					titleBackgroundSkin.addEventListener(MouseEvent.MOUSE_MOVE,onBorderOver,false,0,true);
				}
				skin.mouseChildren = false;
				skin.addEventListener(MouseEvent.MOUSE_MOVE,onBorderOver,false,0,true);
				skin.addEventListener(MouseEvent.ROLL_OVER,onBorderOver,false,0,true);
				skin.addEventListener(MouseEvent.ROLL_OUT,onBorderOut,false,0,true);
				skin.addEventListener(MouseEvent.MOUSE_DOWN,onBorderDown,false,0,true);
			} else {
				if(titleBackgroundSkin != null){
					titleBackgroundSkin.removeEventListener(MouseEvent.ROLL_OVER, onBorderOver);
					titleBackgroundSkin.removeEventListener(MouseEvent.ROLL_OUT, onBorderOut);
					titleBackgroundSkin.removeEventListener(MouseEvent.MOUSE_MOVE, onBorderOver);
				}
				skin.removeEventListener(MouseEvent.MOUSE_MOVE,onBorderOver);
				skin.removeEventListener(MouseEvent.ROLL_OVER, onBorderOver);
				skin.removeEventListener(MouseEvent.ROLL_OUT, onBorderOut);
				skin.removeEventListener(MouseEvent.MOUSE_DOWN, onBorderDown);
			}
		}
		
		public function getResizable():Boolean {
			return _5;
		}
		
		public function setMaximumSize(maximumSize:Rectangle):void {
			_6 = maximumSize;
		}
		
		public function getMaximumSize():Rectangle {
			if (_6 != null) {
				return _6;
			}
			if (stage == null) {
				return null;
			}
			return new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
		}
		
		public function setMinimumSize(minimumSize:Rectangle) {
			_7 = minimumSize;
		}
		
		public function getMinimumSize():Rectangle {
			if (_7 != null) {
				return _7;
			}
			return new Rectangle(0,0,100,100);
		}
		
		[Event(name = "close",type = "flash.events.Event")]
		protected function onClose(evt:MouseEvent):void {
			visible = false;
			dispatchEvent(new Event(Event.CLOSE));
		}
		protected function onDragStart(evt:MouseEvent):void {
			if (WindowManager.getActiveWindow() != this) {
				WindowManager.activate(this);
			}
			if (getResizable() && _9 != null) {
				onBorderDown(evt);
				return;
			}
			_10 = new Point(mouseX,mouseY);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onDragMove,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_UP,onDragStop,false,0,true);
			
		}
		protected function onDragStop(evt:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDragStop);
			stage.mouseChildren = true;
			cacheAsBitmap = false;
			_10 = null;
		}
		protected function onDragMove(evt:MouseEvent):void {
			if(stage.mouseChildren){
				stage.mouseChildren = false;
				cacheAsBitmap = true;
			}
			var _12:Point = _10;
			var _13:Point = new Point(mouseX - _12.x,mouseY - _12.y);
			_13 = localToGlobal(_13);
			var _14:Number,_15:Number,_16:Number,_17:Number;
			var _18:Rectangle = getDragBounds();
			if(_18 == null){
				_14 = -_12.x;
				_15 = -_12.y;
				_16 = stage.stageWidth + width - _12.x;
				_17 = stage.stageHeight + height - _12.y;
			}else{
				_14 = _18.x;
				_15 = _18.y;
				_16 = _18.width;
				_17 = _18.height;
			}
			_13.x = Math.max(_14,Math.min(_16 - width,_13.x));
			_13.y = Math.max(_15,Math.min(_17 - height,_13.y));
									if (_13.x == x && _13.y == y) {
				return;
			}
			x = _13.x;
			y = _13.y;
			evt.updateAfterEvent();
		}
		protected function onBorderOver(evt:MouseEvent):void {
			if (WindowManager.getActiveWindow() != this) {
				return;
			}
			if (evt.buttonDown) {
				return;
			}
			var _12:Number = skin.width;
			var _13:Number = skin.height;
			var _14:Number = mouseX;
			var _15:Number = mouseY;
			var _16:Point = new Point();
			if(_14 >= 0 && _14 <= _12 && _15 >= 0 && _15 <= _13){
				if (_14 <= _contentPaddingLeft) {
					_16.x = -1;
				} else if (_14 >= _12 - _contentPaddingLeft) {
					_16.x = 1;
				}
				if (_15 <= _contentPaddingLeft) {
					_16.y = -1;
				} else if (_15 >= _13 - _contentPaddingLeft) {
					_16.y = 1;
				}
				if (_16.y != 0 && _16.x == 0) {
					if (_14 <= _contentPaddingLeft * 2) {
						_16.x = -1;
					} else if (_14 >= _12 - _contentPaddingLeft*2) {
						_16.x = 1;
					}
				}
			}
			if (_16.x == 0 && _16.y == 0) {
				if (CursorManager.getCursor() != null) {
					CursorManager.setCursor(null);
				}
				_9 = null;
				return;
			}
			var _17:String;
			if (_16.x == _16.y) {
				_17 = "SizeNWSE";
			} else if (Math.abs(_16.x) == Math.abs(_16.y)) {
				_17 = "SizeNESW";
			} else if (_16.y != 0) {
				_17 = "SizeNS";
			} else {
				_17 = "SizeWE";
			}
			try{
				var _18:Class = getDefinitionByName(_17) as Class;
				if (!(CursorManager.getCursor() is _18)) {
					CursorManager.setCursor(_18);
				}
											}catch(e:ReferenceError){
			}
			_9 = _16;
		}
		protected function onBorderOut(evt:MouseEvent):void{
			if (!skin.mouseEnabled) {
				return;
			}
			if(_9 != null){
				CursorManager.setCursor(null);
				_9 = null;
			}
		}
		protected function onBorderDown(evt:MouseEvent):void {
			if (_9 == null) {
				return;
			}
			_11 = new Rectangle(x,y,_width,_height);
			_10 = new Point(evt.stageX,evt.stageY);
			skin.removeEventListener(MouseEvent.MOUSE_MOVE, onBorderOver);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onBorderScale,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_UP,onBorderUp,false,0,true);
			
		}
		protected function onBorderUp(evt:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onBorderScale);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onBorderUp);
			stage.mouseChildren = true;
			skin.mouseEnabled = true;
			skin.cacheAsBitmap = false;
			_11 = null;
			_10 = null;
			onBorderOver(evt);
			skin.addEventListener(MouseEvent.MOUSE_MOVE,onBorderOver,false,0,true);
		}
		protected function onBorderScale(evt:MouseEvent):void {
			if(stage.mouseChildren){
				stage.mouseChildren = false;
				skin.mouseEnabled = false;
				skin.cacheAsBitmap = true;
			}
			var _12:Point = _10;
			var _13:Number = evt.stageX - _12.x;
			var _14:Number = evt.stageY - _12.y;
			var _15:Point = _9;
			var _16:Rectangle = _11;
			var _17:Rectangle = getMinimumSize();
			var _18:Rectangle = getMaximumSize();
			var _19:Number = _16.width + _13 * _15.x;
			_19 = int(_19);
			_19 = Math.max(_17.width,Math.min(Math.min(_18.width,_15.x < 0 ? _16.width+_16.x : stage.stageWidth-_16.x),_19));
			var _20:Number = _16.height +  +  _14 * _15.y;
			_20 = int(_20);
			_20 = Math.max(_17.height,Math.min(Math.min(_18.height,_15.y < 0 ? _16.height+_16.y : stage.stageHeight-_16.y),_20));
			if (_19 == _width && _20 == _height) {
				return;
			}
			if (_15.x < 0) {
				var _21:Number = _16.x - (_19 - _16.width);
				_21 = int(_21);
				if (this.x != _21) {
					this.x = _21;
				}
			}
			if (_15.y < 0) {
				var _22:Number = _16.y - (_20 - _16.height);
				_22 = int(_22);
				if (this.y != _22) {
					this.y = _22;
				}
			}
			setSize(_19,_20);
			evt.updateAfterEvent();
		}
		protected function onAddedToStage(evt:Event):void {
						if(visible){
				WindowManager.activate(this);
				dispatchEvent(new Event("show"));
			}
		}
		protected function onKeyDown(evt:KeyboardEvent):void {
			if(evt.keyCode == Keyboard.ESCAPE){
				if(closeButton == null || !closeButton.enabled){
					return;
				}
				onClose(null);
				evt.stopPropagation();
				return;
			}
			
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _12:Number = _width;
			var _13:Number = _height;
			skin.width = _12;
			skin.height = _13;
			if (titleBackgroundSkin != null) {
				titleBackgroundSkin.width = _12 - titleBackgroundSkin.x * 2;
			}
			var _14:Number = _titleBarPaddingLeft;
			if (icon != null) {
				icon.x = _14;
				icon.y = Math.ceil((_contentPaddingTop - icon.height)/2);
				_14 +=  icon.width + _titleBarPaddingLeft;
			}
			if (titleTextField != null) {
				if(_1 != null){
					titleTextField.htmlText = _1;
					var _15:TextFormat = enabled ? getTextFormat() : getDisabledTextFormat();
					if(_15 != null){
						titleTextField.setTextFormat(_15);
					}
				}
				titleTextField.x = _14;
			}
			var _16:Number = _12 - _titleBarPaddingRight;
			if (closeButton != null) {
				closeButton.x = _16 -= closeButton.width;
			}
			if (titleTextField != null) {
				titleTextField.width = _16 - titleTextField.x;
			}
			content.setSize(_12 - _contentPaddingLeft - _contentPaddingRight,_13 - _contentPaddingTop - _contentPaddingBottom);
		}
		
	}
}

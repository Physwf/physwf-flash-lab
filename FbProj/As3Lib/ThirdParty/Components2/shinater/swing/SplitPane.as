package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import shinater.swing.managers.CursorManager;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class SplitPane extends Container {
		
		public static const HORIZONTAL_SPLIT:String = "horizontal";
		
		public static const VERTICAL_SPLIT:String = "vertical";
		private var _1:String = HORIZONTAL_SPLIT;
		private var _2:DisplayObject;
		private var _3:DisplayObject;
		private var _4:Rectangle;
		private var _5:Rectangle;
		private var _6:Boolean = true;
		private var _7:Number;
		private var _8:Number;
		private var _9:Number = 0;
		protected var _width:Number;
		protected var _height:Number;
		protected var _contentPadding:Number = 0;
		
		private var _10:Number;
		private var _11:DisplayObject;
		
		public var dividerSkin:Sprite;
		
		public var skin:Sprite;
		
		public function SplitPane(){
			super();
		}
		protected override function init():void{
			_width = super.width;
			_height = super.height;
			scaleX = scaleY = 1;
			super.init();
			_contentPadding = dividerSkin.y;
			dividerSkin.mouseChildren = false;
			dividerSkin.addEventListener(MouseEvent.ROLL_OVER,onDividerOver,false,0,true);
			dividerSkin.addEventListener(MouseEvent.ROLL_OUT,onDividerOut,false,0,true);
			dividerSkin.addEventListener(MouseEvent.MOUSE_DOWN,onDividerDown,false,0,true);
			repaint();
		}
		public override function set width(value:Number):void{
			if (_width == value) {
				return;
			}
			_width = value;
			repaint();
			dispatchEvent(new Event(Event.RESIZE,false));
		}
		public override function set height(value:Number):void{
			if (_height == value) {
				return;
			}
			_height = value;
			repaint();
			dispatchEvent(new Event(Event.RESIZE,false));
		}
		public override function setSize(width:Number, height:Number):void{
			if (_width == width && _height == height) {
				return;
			}
			_width = width;
			_height = height;
			repaint();
			dispatchEvent(new Event(Event.RESIZE,false));
		}
		
		public function setOrientation(orientation:String):void {
			setDirection(orientation);
		}
		
		public function getOrientation():String {
			return getDirection();
		}
		
		public function setDirection(direction:String):void {
			_1 = direction;
			repaint();
		}
		
		public function getDirection():String {
			return _1;
		}
		
		public function setLeftComponent(component:DisplayObject):void{
			if(_2 != null){
				removeChild(_2);
			}
			_2 = component;
			if(component != null){
				addChildAt(component, numChildren-1);
				_4 = new Rectangle(0,0,component.width,component.height);
			}
			resetToPreferredSizes();
		}
		
		public function getLeftComponent():DisplayObject{
			return _2;
		}
		
		public function setRightComponent(component:DisplayObject):void{
			if(_3 != null){
				removeChild(_3);
			}
			_3 = component;
			if(component != null){
				addChildAt(component, numChildren-1);
				_5 = new Rectangle(0,0,component.width,component.height);
			}
			resetToPreferredSizes();
		}
		
		public function getRightComponent():DisplayObject{
			return _3;
		}
		
		public function setTopComponent(component:DisplayObject):void{
			setLeftComponent(component);
		}
		
		public function getTopComponent():DisplayObject{
			return getLeftComponent();
		}
		
		public function setBottomComponent(component:DisplayObject):void{
			setRightComponent(component);
		}
		
		public function getBottomComponent():DisplayObject{
			return getRightComponent();
		}
		
		public function setMaximumDividerLocation(location:Number):void{
			_8 = location;
		}
		
		public function getMaximumDividerLocation():Number{
			var _12:Number = Math.max(0,(_1 == HORIZONTAL_SPLIT ? _width : _height) - _contentPadding*2 - getDividerSize());
			if(isNaN(_8)){
				return _12;
			}
			if(_8 < 0){
				return Math.max(_9,_12 + _8);
			}
			return Math.min(Math.max(_9,_8),_12);
		}
		
		public function setMinimumDividerLocation(location:Number):void{
			_9 = Math.max(0,location);
		}
		
		public function getMinimumDividerLocation():Number{
			var _12:Number = Math.max(0,(_1 == HORIZONTAL_SPLIT ? _width : _height) - _contentPadding*2 - getDividerSize());
			return Math.min(_9, _12);
		}
		
		public function setDividerLocation(location:Number):void{
			location = Math.max(0,location);
			if(_7 == location){
				return;
			}
			_7 = location;
			repaint();
		}
		
		public function getDividerLocation():Number{
			return Math.min(_7, getMaximumDividerLocation());
		}
		
		public function setDividerSize(newSize:Number):void{
			var _12:Rectangle = dividerSkin.getRect(dividerSkin);
			dividerSkin.width = _12.x < 0 ? newSize-_12.x*2 : newSize;
		}
		
		public function getDividerSize():Number{
			var _12:Rectangle = dividerSkin.getRect(dividerSkin);
			return _12.x < 0 ? _12.width+_12.x*2 : dividerSkin.width;
		}
		
		public function resetToPreferredSizes():void{
			if(_2 == null){
				setDividerLocation(_9);
				return;
			}
			if(_3 == null){
				setDividerLocation(getMaximumDividerLocation());
				return;
			}
			var _12:Number;
			var _13:Number;
			if(_1 == HORIZONTAL_SPLIT){
				_12 = _4.width;
				_13 = _5.width;
			}else{
				_12 = _4.height;
				_13 = _5.height;
			}
			if(_12 <= _9){
				setDividerLocation(_9);
				return;
			}
			if(_8 < 0 && Math.abs(_8) >= _13){
				setDividerLocation(getMaximumDividerLocation());
				return;
			}
			setDividerLocation(_12);
		}
		
		public function setContinuousLayout(newContinuousLayout:Boolean){
			_6 = newContinuousLayout;
		}
		
		public function getContinuousLayout():Boolean{
			return _6;
		}
		protected function onDividerOver(evt:MouseEvent):void{
			try{
				var _12:Class = getDefinitionByName(_1 == HORIZONTAL_SPLIT ? "SizeWE" : "SizeNS") as Class;
				CursorManager.setCursor(_12);
			}catch(e:ReferenceError){
			}
		}
		protected function onDividerOut(evt:MouseEvent):void{
			if(!dividerSkin.mouseEnabled){
				return;
			}
			CursorManager.setCursor(null);
		}
		protected function onDividerDown(evt:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onDividerMove,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_UP,onDividerUp,false,0,true);
			stage.mouseChildren = false;
			dividerSkin.mouseEnabled = false;
			dividerSkin.cacheAsBitmap = true;
			_10 = evt.localX;
					}
		protected function onDividerUp(evt:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDividerMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDividerUp);
			stage.mouseChildren = true;
			dividerSkin.mouseEnabled = true;
			dividerSkin.cacheAsBitmap = false;
			_10 = undefined;
			var _12:DisplayObject = _11;
			if(_12 != null){
				removeChild(_12);
				_11 = null;
				dividerSkin.alpha = 1;
				repaint();
			}
			if(!dividerSkin.hitTestPoint(evt.stageX,evt.stageY,true)){
				CursorManager.setCursor(null);
			}
		}
		protected function onDividerMove(evt:MouseEvent):void{
			var _12:Number = (_1 == HORIZONTAL_SPLIT ? mouseX : mouseY) - _10;
			_12 = int(_12 - _contentPadding);
			_12 = Math.min(Math.max(getMinimumDividerLocation(),_12),getMaximumDividerLocation());
			if(_6){
				setDividerLocation(_12);
			}else{
				var _13:Number = _width;
				var _14:Number = _height;
				_13 -= _contentPadding*2;
				_14 -= _contentPadding*2;
				var _15:DisplayObject = _11;
				if(_15 == null){
					var _16:Class = dividerSkin["constructor"] as Class;
					_15 = _11 = new _16() as DisplayObject;
					addChild(_15);
					dividerSkin.alpha = 0.5;
					if(_1 == HORIZONTAL_SPLIT){
						_15.height = _14;
						_15.y = _contentPadding;
					}else{
						_15.height = _13;
						_15.rotation = 90;
						_15.x = _contentPadding + _13;
					}
				}
				_7 = _12;
				_12 += _contentPadding;
				if(_1 == HORIZONTAL_SPLIT){
					_15.x = _12;
				}else{
					_15.y = _12;
				}
			}
			evt.updateAfterEvent();
		}
		public override function repaint():void{
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _12:Number = _width;
			var _13:Number = _height;
			skin.width = _12;
			skin.height = _13;
			_12 -= _contentPadding*2;
			_13 -= _contentPadding*2;
			var _14:Number = getDividerLocation();
			_14 += _contentPadding;
			if(_1 == HORIZONTAL_SPLIT){
				if(_2 != null){
					_2.x = _contentPadding;
					_2.y = _contentPadding;
					_2.width = _14 - _contentPadding;
					_2.height = _13;
				}
				dividerSkin.rotation = 0;
				dividerSkin.height = _13;
				dividerSkin.x = _14;
				dividerSkin.y = _contentPadding;
				if(_3 != null){
					_3.x = _14 + getDividerSize();
					_3.y = _contentPadding;
					_3.width = _contentPadding + _12 - _3.x;
					_3.height = _13;
				}
			}else{
				if(_2 != null){
					_2.x = _contentPadding;
					_2.y = _contentPadding;
					_2.width = _12;
					_2.height = _14 - _contentPadding;
				}
				dividerSkin.rotation = 0;
				dividerSkin.height = _12;
				dividerSkin.rotation = 90;
				dividerSkin.x = _contentPadding + _12;
				dividerSkin.y = _14;
				if(_3 != null){
					_3.x = _contentPadding;
					_3.y = _14 + getDividerSize();
					_3.width = _12;
					_3.height = _contentPadding + _13 - _3.y;
				}
			}
		}
	}
}

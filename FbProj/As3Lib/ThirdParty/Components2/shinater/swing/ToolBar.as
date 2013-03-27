package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import shinater.swing.managers.StyleManager;

	
	public dynamic class ToolBar extends Container {
		
		public static const HORIZONTAL:String = "horizontal";
		
		public static const VERTICAL:String = "vertical";
		
		public var separatorSkin:Sprite;
		
		public var skin:Sprite;
		private var _1:DisplayObjectContainer;
		private var _2:Array = [];
		private var _3:String = HORIZONTAL;
		private var _4:Boolean = true;
		private var _5:Boolean = false;
		protected var _width:Number;
		protected var _height:Number;
		protected var _contentPadding:Number = 0;
		protected var _margin:Number = 20;
		
		private var _6:Sprite;
		private var _7:Point;
		private var _8:String;
		private var _9:String;
		
		public function ToolBar() {
			super();
		}
		protected override function init():void{
			_width = super.width;
			_height = super.height;
			scaleX = scaleY = 1;
			if (rotation == -90) {
				rotation = 0;
				_3 = VERTICAL;
				y -= _height;
			}
			super.init();
			_contentPadding = separatorSkin.y;
			_1 = new Sprite();
			_1.addChild(skin);
			addChild(_1);
			removeChild(separatorSkin);
			tabChildren = false;
			setFocusEnabled(false);
			skin.addEventListener(MouseEvent.MOUSE_DOWN,onDragStart,false,0,true);
			repaint();
		}
		public override function get width():Number{
			return !_5 ? _width : super.width;
		}
		public override function set width(value:Number):void{
			if(_width == value){
				return;
			}
			_width = value;
			repaint();
		}
		public override function get height():Number{
			return !_5 ? _height : super.height;
		}
		public override function set height(value:Number):void{
			if(_height == value){
				return;
			}
			_height = value;
			repaint();
		}
		public override function setSize(width:Number, height:Number):void{
			if(_width == width && _height == height){
				return;	
			}
			_width = width;
			_height = height;
			repaint();
		}
		public override function addChild(child:DisplayObject):DisplayObject {
			super.addChild(child);
			if(child is Component){
				_2.push(child);
				repaint();
			}
			return child;
		}
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject {
			super.addChildAt(child, index);
			if(child is Component){
				for(var _10:int = index + 1,_11:uint = numChildren; _10<_11; _10++){
					index = _2.indexOf(getChildAt(_10));
					if(index != -1){
						_2.splice(index,0,child);
						return child;
					}
				}
				_2.push(child);
				repaint();
			}
			return child;
		}
		public override function removeChild(child:DisplayObject):DisplayObject {
			return removeChildAt(getChildIndex(child));
		}
		public override function removeChildAt(_11:int):DisplayObject {
			var _10:DisplayObject = super.removeChildAt(_11);
			var _11:int = _2.indexOf(_10);
			if(_11 != -1){
				_2.splice(_11,1);
			}
			repaint();
			return _10;
		}
		
		
		public function addSeparator():void {
			var _10:DisplayObject = _2.indexOf(separatorSkin) == -1 ? separatorSkin : createSeparator();
			super.addChild(_10);
			_2.push(_10);
		}
		
		public function setMargin(margin:int):void {
			_margin = margin;
		}
		
		public function getMargin():int {
			return _margin;
		}
		
		public function setOrientation(orientation:String):void {
			setDirection(orientation);
		}
		
		public function getOrientation():String {
			return getDirection();
		}
		
		public function setDirection(direction:String):void {
			if(_3 == direction){
				return;
			}
			_3 = direction;
			var _10:Number = _width;
			_width = _height;
			_height = _10;
			repaint();
		}
		
		public function getDirection():String {
			return _3;
		}
		
		public function setFloatable(floatable:Boolean):void {
			_4 = floatable;
		}
		
		public function getFloatable():Boolean {
			return _4;
		}
		
		public function setAutoSize(auto:Boolean):void {
			_5 = auto;
			repaint();
		}
		
		public function getAutoSize():Boolean {
			return _5;
		}
		protected function createSeparator():DisplayObject {
			var _10:Class = separatorSkin["constructor"] as Class;
			var _11:DisplayObject = new _10() as DisplayObject;
			return _11;
		}
		protected function onDragStart(evt:MouseEvent):void{
			if(!getFloatable()){
				return;
			}
			if(!(parent is BorderLayoutPanel)){
				return;
			}
			_7 = new Point(mouseX,mouseY);
			_8 = _3;
			_9 = null;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onDragOver,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_UP,onDragStop,false,0,true);
					}
		protected function onDragOver(evt:MouseEvent):void{
			if(stage.mouseChildren){
				stage.mouseChildren = false;
			}
			var _10:Sprite = _6;
			if(_10 == null){
				_10 = new Sprite();
				var _11:BitmapData = new BitmapData(2,2);
				_11.setPixel(0,0,0);
				_11.setPixel(1,1,0);
				var _12:Graphics = _10.graphics;
				_12.lineStyle(0,0,0);
				_12.beginBitmapFill(_11);
				_12.drawRect(0,0,width,height);
				_12.drawRect(2,2,width-4,height-4);
				_12.endFill();
				_12.beginFill(0,0);
				_12.drawRect(2,2,width-4,height-4);
				_12.endFill();
				DisplayObjectContainer(root).addChild(_10);
				_6 = _10;
			}
			var _13:BorderLayoutPanel = BorderLayoutPanel(parent);
			var _14:Number = _13.width;
			var _15:Number = _13.height;
			var _16:Number = _13.mouseX;
			var _17:Number = _13.mouseY;
			var _18:String = null;
			var _19:Object = _13.getInsets();
			var _20:String = BorderLayoutPanel.TOP;
			var _21:String = BorderLayoutPanel.BOTTOM;
			var _22:String = BorderLayoutPanel.LEFT;
			var _23:String = BorderLayoutPanel.RIGHT;
			var _24:DisplayObject = _13.getLayoutComponent(_20);
			var _25:Number = _24 == null ? 0 : _24.height;
			var _26:DisplayObject = _13.getLayoutComponent(_21);
			var _27:Number = _26 == null ? 0 : _26.height;
			var _28:DisplayObject = _13.getLayoutComponent(_22);
			var _29:Number = _28 == null ? 0 : _28.width;
			var _30:DisplayObject = _13.getLayoutComponent(_23);
			var _31:Number = _30 == null ? 0 : _30.width;
			var _32:String = _8;
			if(_16 >= _29 && _17 >= _25 && _16 <= _14-_31 && _17 <= _15-_27){
				if(_24 == null && _19.top > 0 && _17 <= _19.top){
					_18 = _20;
				}else if(_26 == null && _19.bottom > 0 && _17 >= _15 - _19.bottom){
					_18 = _21;
				}else if(_28 == null && _19.left > 0 && _16 <= _19.left){
					_18 = _22;
				}else if(_30 == null && _19.right > 0 && _16 >= _14 - _19.right){
					_18 = _23;
				}
				if(_32 == VERTICAL){
					if(_28 == null && _19.left > 0 && _16 <= _19.left){
						_18 = _22;
					}else if(_30 == null && _19.right > 0 && _16 >= _14 - _19.right){
						_18 = _23;
					}
				}
			}
			var _33:Number = width;
			var _34:Number = height;
			var _35:String = _32;
			if(_18 != null){
				_35 = _18 == _20 || _18 == _21 ? HORIZONTAL : VERTICAL;
				if(_35 != _32){
					_33 = _34;
					_34 = width;
					if(!getAutoSize()){
						if(_35 == VERTICAL){
							var _36:Number = _13.getVgap();
							_34 = _15 - (_25 != 0 ? _25+_36 : 0) - (_27 != 0 ? _27+_36 : 0);
						}else{
							var _37:Number = _13.getHgap();
							_33 = _14 - (_29 != 0 ? _29+_37 : 0) - (_31 != 0 ? _31+_37 : 0);
						}
					}
				}
			}
			if(_10.width != _33 || _10.height != _34){
				_11 = new BitmapData(2,2);
				_11.setPixel(0,0,0);
				_11.setPixel(1,1,0);
				_12 = _10.graphics;
				_12.clear();
				_12.lineStyle(0,0,0);
				_12.beginBitmapFill(_11);
				_12.drawRect(0,0,_33,_34);
				_12.drawRect(2,2,_33-4,_34-4);
				_12.endFill();
				_12.beginFill(0,0);
				_12.drawRect(2,2,_33-4,_34-4);
				_12.endFill();
			}
			var _38:Point = _7;
			var _39:Point = new Point();
			if(_35 == _32){
				_39.x = _16 - _38.x;
				_39.y = _17 - _38.y;
			}else{
				_39.x = _16 - _38.y;
				_39.y = _17 - _38.x;
			}
			_39 = _13.localToGlobal(_39);
			_39.x = Math.max(0, Math.min(stage.stageWidth-_33,_39.x));
			_39.y = Math.max(0, Math.min(stage.stageHeight-_34,_39.y));
			_39 = root.globalToLocal(_39);
			_10.x = _39.x;
			_10.y = _39.y;
			var _40:Sprite = _13.topArea;
			if(_40 != null){
				_40.visible = _18 == _20;
			}
			var _41:Sprite = _13.bottomArea;
			if(_41 != null){
				_41.visible = _18 == _21;
			}
			var _42:Sprite = _13.leftArea;
			if(_42 != null){
				_42.visible = _18 == _22;
			}
			var _43:Sprite = _13.rightArea;
			if(_43 != null){
				_43.visible = _18 == _23;
			}
			evt.updateAfterEvent();
			_9 = _18;
		}
		protected function onDragStop(evt:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragOver);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDragStop);
			stage.mouseChildren = true;
			var _10:Sprite = _6;
			if(_10 != null){
				_10.parent.removeChild(_10);
			}
			var _11:BorderLayoutPanel = BorderLayoutPanel(parent);
			var _12:String = _9;
			if(_12 != null && _11.getLayoutComponent(_12) != this){
				setDirection(_12 == BorderLayoutPanel.TOP || _12 == BorderLayoutPanel.BOTTOM ? HORIZONTAL : VERTICAL);
				_11.addLayoutComponent(this,_12);
			}
			_7 = null;
			_8 = null;
			_9 = null;
			_6 = null;
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _10:Number = _width;
			var _11:Number = _height;
			var _12:Number, _13:Number;
			var _14:Number = 0, _15:Number = 0;
			var _16:DisplayObject;
			if(_3 == VERTICAL){
				var _17:int = 1;
				var _18:int = 0;
				var _19:int = 1;
				if(_5){
					_13 = _margin;
					for(var _20:int = 0,_21:uint = _2.length; _20<_21;){
						_15 = 0;
						_18 = 0;
						for(var _22:int = 0; _22<_17; _22++){
							_16 = _2[_20+_22];
							if(!(_16 is Component)){
								if(_16 != null){
									if(_15 != 0){
										_13 += _15 + _contentPadding;
									}
									_15 = _16.rotation == 0 ? _16.width : _16.height;
								}
								_20 += _22+1;
								break;
							}
							_18++;
							_19 = Math.max(_19,_18);
							_14 = Math.max(_14, _16.width);
							_15 = Math.max(_15,_16.height);
							if(_22 == _17 - 1){
								_20 += _17;
							}
						}
						if(_17 <= _19 && _20 >= _21 - 1 && _13 + _15 + _margin > _11){
							_17++;
							_13 = _margin;
							_20 = 0;
						}else{
							_13 += _15 + _contentPadding;
						}
					}
					_17 = Math.min(_17,_19);
				}else{
					for(_20 = 0,_21 = _2.length; _20<_21; _20++){
						_16 = _2[_20];
						if(_16 is Component){
							_14 = Math.max(_14, _16.width);
						}
					}
					if(_14 > 0){
						_17 = Math.max(1,(_10-_contentPadding)/(_14+_contentPadding));
					}
					_14 = Math.max(_14,(_10-_contentPadding)/_17 - _contentPadding);
				}
				_13 = _margin;
				for(_20 = 0,_21 = _2.length; _20<_21;){
					_12 = _contentPadding;
					_15 = 0;
					for(_22 = 0; _22<_17; _22++){
						_16 = _2[_20+_22];
						if(_16 is Component){
							_15 = Math.max(_15,_16.height);
							if(_22 < _17-1 && _20+_22 < _21-1){
								continue;
							}
						}
						for(var _23:int = 0; _23<=_22; _23++){
							_16 = _2[_20+_23];
							if(!(_16 is Component)){
								_16.rotation = 0;
								_16.height = _5 ? _14*_17 + _contentPadding*(_17-1) : _10 - _contentPadding*2;
								_16.rotation = 90;
								_16.x = _contentPadding + _16.width;
								if(_15 != 0){
									_13 += _15 + _contentPadding;
								}
								_16.y = _13;
								_15 = _16.height;
							}else{
								_16.x = _12 + (_5||_10-_contentPadding*2 >= _14 ? int((_14-_16.width)/2) : 0);
								_12 += _14 + _contentPadding;
								_16.y = _13 + int((_15-_16.height)/2);
							}
						}
						_20 += _22 + 1;
						break;
					}
					if(_20 < _21){
						_13 += _15 + _contentPadding;
					}
				}
				if(_5){
					scrollRect = null;
					_10 = _contentPadding*(_17+1) + _14*_17;
					_11 = _13 + _15 + _margin;
				}else{
					if((_contentPadding+_14)*_17 > _10 || _13+_15 > _11){
						scrollRect = new Rectangle(0,0,_10,_11);
					}else{
						scrollRect = null;
					}
				}
			}else{
				for(_20 = 0,_21 = _2.length; _20<_21; _20++){
					_16 = _2[_20];
					if(_16 is Component){
						_15 = Math.max(_15, _16.height);
					}
				}
				_12 = _margin;
				_13 = _contentPadding; 
				var _24:Number = _12;
				var _25:int = 1;
				for(_20 = 0,_21 = _2.length; _20<_21; _20++){
					_16 = _2[_20];
					if(_20 > 0 && _12+_16.width+_margin > _10 && (_5 || _13+_15+_contentPadding <= _11)){
						_12 = _margin;
						_13 += _15 + _contentPadding;
						_25++;
					}
					if(!(_16 is Component)){
						_16.rotation = 0;
						_16.y = _13;
						_16.height = _15;
					}else{
						_16.y = _13 + int((_15-_16.height)/2);
					}
					_16.x = _12;
					_12 += _16.width;
					_24 = Math.max(_24, _12);
					_12 += _contentPadding;
				}
				if(_5){
					scrollRect = null;
					_10 = _24 + _margin;
					_11 = _13 + _15 + _contentPadding;
				}else{
					_15 = Math.max(_15,int((_11-_contentPadding*(_25+1))/_25));
					_13 = _contentPadding;
					for(_20 = 0,_21 = _2.length; _20<_21; _20++){
						_16 = _2[_20];
						if(_20 > 0 && _16.x == _margin){
							_13 += _15 + _contentPadding;
						}
						if(!(_16 is Component)){
							_16.y = _13;
							_16.height = _15;
						}else{
							_16.y = _13 + int((_15-_16.height)/2);
						}
					}
					if(_24 > _10){
						scrollRect = new Rectangle(0,0,_10,_11);
					}else{
						scrollRect = null;
					}
				}
			}
			if(_3 == VERTICAL){
				_1.rotation = -90;
				_1.scaleX = -1;
				skin.width = _11;
				skin.height = _10;
			}else{
				_1.rotation = 0;
				_1.scaleX = 1;
				skin.width = _10;
				skin.height = _11;
			}
		}
	}
}

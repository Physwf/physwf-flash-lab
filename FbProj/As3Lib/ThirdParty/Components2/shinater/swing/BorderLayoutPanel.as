package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class BorderLayoutPanel extends Panel{
		
		public static const TOP:String = "top";
		
		public static const BOTTOM:String = "bottom";
		
		public static const LEFT:String = "left";
		
		public static const RIGHT:String = "right";
		
		public static const CENTER:String = "center";
		
		public var topArea:Sprite;
		
		public var bottomArea:Sprite;
		
		public var leftArea:Sprite;
		
		public var rightArea:Sprite;
		private var _1:Rectangle;
		private var _2:Number = 0;
		private var _3:Number = 0;
		private var _4:Object = {};
		
		protected var _contentPaddingX:Number = 0;
		protected var _contentPaddingY:Number = 0;
		
		public function BorderLayoutPanel() {
			super();
		}
		protected override function init():void {
			super.init();
			if(topArea != null || bottomArea != null || leftArea != null || rightArea != null){
				_1 = new Rectangle();
				if(leftArea != null){
					_contentPaddingX = leftArea.x;
					_contentPaddingY = leftArea.y;
					_1.left = leftArea.width;
				}
				if(rightArea != null){
					_1.right = rightArea.width;
				}
				if(topArea != null){
					_contentPaddingX = topArea.x;
					_contentPaddingY = topArea.y;
					_1.top = topArea.height;
				}
				if(bottomArea != null){
					_1.bottom = bottomArea.height;
				}
			}
			repaint();
		}
		public override function get width():Number{
			return _width;
		}
		public override function get height():Number{
			return _height;
		}
		
		public function getInsets():Object{
			if(_1 == null){
				return new Rectangle();
			}
			return _1.clone();
		}
		
		public function setHgap(hgap:Number):void{
			_2 = hgap;
			repaint();
		}
		
		public function getHgap():Number{
			return _2;
		}
		
		public function setVgap(vgap:Number):void{
			_3 = vgap;
			repaint();
		}
		
		public function getVgap():Number{
			return _3;
		}
		
		public function addLayoutComponent(component:DisplayObject, location:String):void{
			if(_4[location] != null){
				removeChild(_4[location]);
			}
			if(component != null && component.parent == this){
				removeLayoutComponent(component);
			}
			addChildAt(component,skin != null ? 1 : 0);
			_4[location] = component;
			repaint();
		}
		
		public function removeLayoutComponent(component:DisplayObject):void{
			for(var _5:String in _4){
				if(_4[_5] == component){
					removeChild(component);
					_4[_5] = null;
					break;
				}
			}
		}
		
		public function getLayoutComponent(location:String):DisplayObject{
			return _4[location];
		}
		public override function repaint():void {
			
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _5:Number = _width;
			var _6:Number = _height;
			skin.width = _5;
			skin.height = _6;
			_5 -= _contentPaddingX*2;
			_6 -= _contentPaddingY*2;
			var _7:Rectangle = new Rectangle();
			var _8:DisplayObject = _4[TOP];
			var _9:Number = 0;
			if(_8 != null){
				_8.x = _contentPaddingX;
				_8.y = _contentPaddingY;
				_8.width = _5;
				_7.top = _8.height;
				_9 = _3;
			}
			var _10:DisplayObject = _4[BOTTOM];
			var _11:Number = 0;
			if(_10 != null){
				_10.x = _contentPaddingX;
				_10.y = _contentPaddingY + _6 - _10.height;
				_10.width = _5;
				_7.bottom = _10.height;
				_11 = _3;
			}
			var _12:Number = Math.max(0,_6-_7.top-_7.bottom-_9-_11);
			var _13:DisplayObject = _4[LEFT];
			var _14:Number = 0;
			if(_13 != null){
				_13.x = _contentPaddingX;
				_13.y = _contentPaddingY + _7.top + _9;
				_13.height = _12;
				_7.left = _13.width;
				_14 = _2;
			}
			var _15:DisplayObject = _4[RIGHT];
			var _16:Number = 0;
			if(_15 != null){
				_15.x = _contentPaddingX + _5 - _15.width;
				_15.y = _contentPaddingY + _7.top + _9;
				_15.height = _12;
				_7.right = _15.width;
				_16 = _2;
			}
			var _17:Number = Math.max(0,_5-_7.left-_7.right-_14-_16);
			var _18:DisplayObject = _4[CENTER];
			if(_18 != null){
				_18.x = _contentPaddingX + _7.left + _14;
				_18.y = _contentPaddingY + _7.top + _9;
				if(_18 is Component){
					Component(_18).setSize(_17,_12);
				}else{
					_18.width = _17;
					_18.height = _12;
				}
			}
			if(topArea != null){
				topArea.x = _contentPaddingX + _7.left + _14;
				topArea.width = _17;
				topArea.visible = false;
			}
			if(bottomArea != null){
				bottomArea.x = _contentPaddingX + _7.left + _14;
				bottomArea.y = _contentPaddingY + _6 - bottomArea.height;
				bottomArea.width = _17;
				bottomArea.visible = false;
			}
			if(leftArea != null){
				leftArea.y = _contentPaddingY + _7.top + _9;
				leftArea.height = _12;
				leftArea.visible = false;
			}
			if(rightArea != null){
				rightArea.x = _contentPaddingX + _5 - rightArea.width;
				rightArea.y = _contentPaddingY + _7.top + _9;
				rightArea.height = _12;
				rightArea.visible = false;
			}
		}
	}
}

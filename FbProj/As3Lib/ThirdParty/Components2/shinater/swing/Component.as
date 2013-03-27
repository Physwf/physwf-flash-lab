
package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import shinater.swing.managers.CursorManager;
	import shinater.swing.managers.ToolTipManager;
	import shinater.swing.managers.FocusManager;

	
	public dynamic class Component extends MovieClip {
		private var _1:TextFormat; 
		private var _2:TextFormat;
		private var _3:String;
		private var _4:Boolean = true;
		private var _5:Menu;
		private var _6:DisplayObject;
		
		public var focusRectSkin:Sprite;
		protected var _focusRectPaddingX:Number = 0;
		protected var _focusRectPaddingY:Number = 0;
		
		public function Component() {
			super();
			init();
		}
		protected function init():void {
			focusRect = false;
			if(focusRectSkin != null){
				focusRectSkin.alpha = 1;
				focusRectSkin.visible = false;
			}
			tabEnabled = true;
			tabIndex = 0;
			if (scaleX != 1 || scaleY != 1) {
				var _7:Number = super.width;
				var _8:Number = super.height;
				scaleX = scaleY = 1;
				setSize(_7,_8);
			}
			if(FocusManager.getStage() == null){
				addEventListener(Event.ADDED_TO_STAGE,onAddedToStage,false,0,true);
			}
		}
		
		public override function set mouseEnabled(value:Boolean):void {
			super.mouseEnabled = value;
			mouseChildren = value;
		}
		public override function set enabled(value:Boolean):void {
			super.enabled = value;
			mouseEnabled = value;
		}
		
		public function setEnabled(enabled:Boolean):void {
			this.enabled = enabled;
		}
		
		public function getEnabled():Boolean {
			return enabled;
		}
		
		public function setVisible(visible:Boolean):void {
			this.visible = visible;
		}
		
		public function getVisible():Boolean {
			return visible;
		}
		
		public function setLocation(x:Number,y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		public function getX():Number {
			return x;
		}
		
		public function getY():Number {
			return y;
		}
		
		public function setSize(width:Number,height:Number):void {
			this.width = width;
			this.height = height;
		}
		
		public function getWidth():Number {
			return width;
		}
		
		public function getHeight():Number {
			return height;
		}
		
		public function setTextFormat(textFormat:TextFormat):void {
			_1 = textFormat;
			repaint();
		}
		
		public function getTextFormat():TextFormat {
			return _1;
		}
		
		public function setDisabledTextFormat(textFormat:TextFormat):void{
			_2 = textFormat;
			if (! enabled) {
				repaint();
			}
		}
		
		public function getDisabledTextFormat():TextFormat{
			return _2;
		}
		
		public function setCursor(cursor:DisplayObject):void {
			if (_6 == null) {
				if (cursor != null) {
										addEventListener(MouseEvent.MOUSE_OVER,onMouseOver,false,0,true);
					addEventListener(MouseEvent.ROLL_OUT,onMouseOut,false,0,true);
				}
			} else if (cursor == null) {
								removeEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
				removeEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			}
			_6 = cursor;
		}
		
		public function getCursor():DisplayObject {
			return _6;
		}
		
		public function setFocus():void {
			if (getFocusEnabled()) {
				FocusManager.setFocus(this);
			}
		}
		
		public function getFocus():InteractiveObject {
			return FocusManager.getFocus();
		}
		
		
		
		public function setFocusEnabled(focusEnabled:Boolean):void {
			_4 = focusEnabled;
		}
		
		public function getFocusEnabled():Boolean {
			return _4;
		}
		
		public function setTabEnabled(tabEnabled:Boolean):void {
			this.tabEnabled = tabEnabled;
		}
		
		public function getTabEnabled():Boolean {
			return tabEnabled;
		}
		
		public function setTabIndex(tabIndex:int):void {
			this.tabIndex = tabIndex;
		}
		
		public function getTabIndex():int {
			return tabIndex;
		}
		
		public function drawFocus(focused:Boolean):void {
						if(focusRectSkin != null && focusRectSkin.visible != focused){
				focusRectSkin.visible = focused;
			}
		}
		
		public function setToolTipText(text:String):void {
			if (_3 == null) {
				if (text != null) {
					ToolTipManager.register(this);
				}
			} else if (text == null) {
				ToolTipManager.unregister(this);
			}
			_3 = text;
		}
		
		public function getToolTipText():String {
			return _3;
		}
		
		public function createToolTip():ToolTip {
			
			var _7:ToolTip = ToolTipManager.getDefaultToolTip();
			_7.setComponent(this);
						return _7;
		}
		
		
		
		public function setContextMenu(contextMenu:Menu):void {
			_5 = contextMenu;
		}
		
		public function getContextMenu():Menu {
			return _5;
		}
		
		
		
		
		public function getParent():Container {
			var _7:DisplayObjectContainer = parent;
			while(_7 != null && _7 != root){
				if(_7 is Container){
					return Container(_7);
				}
				_7 = _7.parent;
			}
			return null;
		}
		private function onAddedToStage(evt:Event):void {
			FocusManager.setStage(stage);
			CursorManager.setStage(stage);
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		private function onMouseOver(evt:MouseEvent):void {
			if (evt.buttonDown) {
				return;
			}
			if (_6 == CursorManager.getCursor()) {
				return;
			}
			CursorManager.setCursor(_6);
		}
		private function onMouseOut(evt:MouseEvent):void {
			CursorManager.setCursor(null);
		}
		
		public function repaint():void {
		}
		
	}
}

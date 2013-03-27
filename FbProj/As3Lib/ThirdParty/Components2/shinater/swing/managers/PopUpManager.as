
package shinater.swing.managers{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import shinater.swing.Component;
	import shinater.swing.ComboBox;
	import shinater.swing.List;
	import shinater.swing.Menu;
	import shinater.swing.MenuBar;
	import shinater.transitions.Tween;
	import shinater.transitions.TweenEvent;
	
	
	public class PopUpManager {
		private static var popupMenuEnabled:Boolean = false;
		private static var focusManagerEnabled:Boolean = true;
		
		public static function setPopupMenuEnabled(enabled:Boolean):void {
			popupMenuEnabled = enabled;
		}
		
		public static function getPopupMenuEnabled():Boolean {
			return popupMenuEnabled;
		}
		use namespace swing_style;
		swing_style static var modalWindow:Sprite;
		swing_style static var mouseReleased:Boolean = true;
		swing_style static var popupComponent:Component;
		swing_style static var popupInvoker:Component;
		
		public static function show(popup:Component,invoker:Component,x:Number,y:Number):void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(PopUpManager,"show",popup,invoker,x,y)){
				return;
			}
			var _1:Point = new Point(x,y);
			_1 = invoker.localToGlobal(_1);
			var _2:DisplayObjectContainer = DisplayObjectContainer(invoker.root);
			if (modalWindow == null) {
				createModalWindow(_2);
			}
			_2.addChild(modalWindow);
			modalWindow.visible = true;
			mouseReleased = false;
			focusManagerEnabled = FocusManager.getEnabled();
			FocusManager.setEnabled(false);
			_2.addChild(popup);
			popup.visible = true;
			popup.dispatchEvent(new Event("show"));
			popupComponent = popup;
			popupInvoker = invoker;
			FocusManager.setFocus(popup);
			var _3:Number = popup.width;
			var _4:Number = popup.height;
			var _5:Stage = invoker.stage;
			var _6:Number = _5.stageWidth;
			var _7:Number = _5.stageHeight;
			if ((popup is List) && (invoker is ComboBox)) {
				if (_1.y + _4 > _7) {
					_1 = invoker.localToGlobal(new Point(x,0));
					_1 = popup.parent.globalToLocal(_1);
					popup.setLocation(_1.x,_1.y);
					popup.scrollRect = new Rectangle(0,0,_3,0);
					new Tween(popup,"y",null,popup.y,popup.y - _4,0.1,true).addEventListener(TweenEvent.MOTION_CHANGE,function(evt:TweenEvent){
					  var _8:Tween = Tween(evt.currentTarget);
					  var _9:DisplayObject = DisplayObject(_8.obj);
					  var _10:Rectangle = _9.scrollRect;
					  _10.height = _8.begin - evt.position;
					  _9.scrollRect = _10;
					  evt.updateAfterEvent();
					});
				} else {
					_1 = popup.parent.globalToLocal(_1);
					popup.setLocation(_1.x,_1.y);
					var _10:Rectangle = new Rectangle(0,_4,_3,_4);
					popup.scrollRect = _10;
					new Tween(popup,"",null,_4,0,0.1,true).addEventListener(TweenEvent.MOTION_CHANGE,function(evt:TweenEvent){
					  var _8:Tween = Tween(evt.currentTarget);
					  var _9:DisplayObject = DisplayObject(_8.obj);
					  var _10:Rectangle = _9.scrollRect;
					  _10.y = evt.position;
					  _9.scrollRect = _10;
					  evt.updateAfterEvent();
					});
				}
				return;
			}
			if (_1.x + _3 > _6) {
				_1.x -=  _3;
			}
			if (_1.y + _4 > _7) {
				_1.y = Math.max(_1.y - _4,0);
			}
			_1 = popup.parent.globalToLocal(_1);
			popup.setLocation(_1.x,_1.y);
		}
		
		public static function hide(popup:Component):void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(PopUpManager,"hide",popup)){
				return;
			}
			popup.visible = false;
			if(popup == popupComponent){
				modalWindow.visible = false;
				popup.dispatchEvent(new Event("hide"));
				FocusManager.setFocus(popupInvoker);
				if(focusManagerEnabled){
					FocusManager.setEnabled(true);
				}
				popupComponent = null;
			}
		}
		swing_style static function createModalWindow(root:DisplayObject) {
			modalWindow = new Sprite();
			var _1:Number = 3000;
			var _2:Number = 2000;
			var _3:Graphics = modalWindow.graphics;
			_3.beginFill(0x000000,0);
			_3.drawRect(0,0,_1,_2);
			_3.endFill();
			modalWindow.tabEnabled = false;
			modalWindow.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown,false,0,true);
			modalWindow.addEventListener(MouseEvent.MOUSE_UP,onMouseUp,false,0,true);
			var _4:Stage = root.stage;
			_4.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown,true,0,true);
			_4.addEventListener(MouseEvent.MOUSE_UP,onMouseUp,false,0,true);
			_4.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
		}
		private static function onMouseDown(evt:MouseEvent):void {
			if(evt.currentTarget != modalWindow){
				if(!mouseReleased){
					mouseReleased = true;
				}
				return;
			}
			hide(popupComponent);
		}
		private static function onMouseUp(evt:MouseEvent):void{
			if(evt.currentTarget != modalWindow){
				if(!mouseReleased){
					mouseReleased = true;
				}
				return;
			}
			if(mouseReleased){
				hide(popupComponent);
			}
		}
		private static function onKeyDown(evt:KeyboardEvent):void{
			if(popupComponent == null){
				return;
			}
			if(evt.keyCode != Keyboard.ESCAPE || evt.isDefaultPrevented()){
				return;
			}
			hide(popupComponent);
		}
	}
}

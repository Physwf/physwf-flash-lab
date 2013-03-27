package shinater.swing.managers{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import shinater.swing.Window;
	import shinater.swing.Frame;
	
	public class WindowManager {
		private static var activeWindows:Array = [];
		use namespace swing_style;
		swing_style static var modalWindow:Sprite;
		
		public static function activate(window:Window):void {
			var _1:Window = getActiveWindow();
			if (_1 == window) {
				return;
			}
			if (_1 != null && _1.getModal()) {
				showBlocking();
				return;
			}
			var _2:int = activeWindows.indexOf(window);
			if (_2 != -1) {
				activeWindows.splice(_2,1);
			}
			if (! (window is Frame)) {
				var _3:DisplayObjectContainer = DisplayObjectContainer(window.root);
				if (window.getModal()) {
					if (modalWindow == null) {
						createModalWindow(_3);
						_3.addChild(modalWindow);
					} else {
						modalWindow.parent.addChild(modalWindow);
						modalWindow.visible = true;
					}
				}
				_3.addChild(window);
			}
			activeWindows.push(window);
			FocusManager.setFocus(window);
		}
		
		public static function deactivate(window:Window):void {
			var _1:int = activeWindows.indexOf(window);
			if (_1 == -1) {
				return;
			}
			if (_1 == activeWindows.length - 1 && window.getModal() && modalWindow != null) {
				modalWindow.visible = false;
			}
			activeWindows.splice(_1,1);
			if (activeWindows.length > 0) {
				FocusManager.setFocus(activeWindows[activeWindows.length - 1]);
			} else {
				FocusManager.setFocus(null);
			}
		}
		
		public static function getActiveWindow():Window {
			if (activeWindows.length == 0) {
				return null;
			}
			return activeWindows[activeWindows.length - 1];
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
		}
		private static function onMouseDown(evt:MouseEvent):void {
			showBlocking();
		}
		private static function showBlocking():void {
			var _1:Window = getActiveWindow();
			var _2:Sprite = _1.skin;
			var _3:Array = _2.filters;
			if (_3 == null) {
				return;
			}
			_2.filters = null;
			setTimeout(function(_2:Sprite, _3:Array){
			   _2.filters = _3;
			   _2 = null;
			   _3 = null;
			},60, _2, _3);
		}
	}
}

package shinater.swing.managers{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.getDefinitionByName;
	
	public class CursorManager {
		private static var stage:Stage;
		public static function setStage(stage:Stage):void {
			if(CursorManager.stage != null){
				return;
			}
			CursorManager.stage = stage;
		}
		public static function getStage():Stage{
			return stage;
		}
		private static var cursor:DisplayObject;
		
		public static function setCursor(cursor:Object):void {
						var _1:DisplayObject = CursorManager.cursor;
			if (_1 != null) {
				_1.parent.removeChild(_1);
			}
			var _2:DisplayObject = null;
			if (cursor != null) {
				if (cursor is DisplayObject) {
					_2 = DisplayObject(cursor);
				} else {
					var _3:Class = null;
					if (cursor is Class) {
						_3 = Class(cursor);
					} else if (cursor is String) {
						try{
							_3 = getDefinitionByName(String(cursor)) as Class;
						}catch(e:ReferenceError){
						}
					}
					if (_3 != null) {
						_2 = new _3() as DisplayObject;
					}
				}
			}
			if (_2 == null) {
				if (_1 != null) {
					stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
					CursorManager.cursor = null;
					Mouse.show();
				}
				return;
			}
			if (_1 == null) {
				Mouse.hide();
				stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove,false,0,true);
			}
			if (_2 is InteractiveObject) {
				InteractiveObject(_2).mouseEnabled = false;
			}
			if (_2 is DisplayObjectContainer){
				DisplayObjectContainer(_2).mouseChildren = false;
			}
			stage.addChild(_2);
			_2.x = stage.mouseX;
			_2.y = stage.mouseY;
			CursorManager.cursor = _2;
		}
		
		public static function getCursor():DisplayObject {
			return cursor;
		}
		
		private static function onMouseMove(evt:MouseEvent):void {
			if(cursor == null){
				return;
			}
			cursor.x = evt.stageX;
			cursor.y = evt.stageY;
			evt.updateAfterEvent();
		}
	}

}

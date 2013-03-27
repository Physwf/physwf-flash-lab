package shinater.swing.managers{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.display.Stage;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import shinater.swing.Component;
	import shinater.swing.Container;
	import shinater.swing.Button;
	import shinater.swing.Window;
	
	public class FocusManager {
		private static var enabled:Boolean = true;
		private static var releaseFocus:Boolean = false;
		private static var focusOwner:InteractiveObject;
		private static var lastFocusOwner:InteractiveObject;
		private static var defaultButton:Button;
		private static var stage:Stage;
		public static function setStage(stage:Stage):void {
			if(FocusManager.stage != null){
				return;
			}
			FocusManager.stage = stage;
			stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,onMouseFocusChange,false,0,true);
			stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,onKeyFocusChange,false,0,true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,false,0,true);
		}
		public static function getStage():Stage{
			return stage;
		}
		
		public static function setEnabled(enabled):void {
			FocusManager.enabled = enabled;
		}
		
		public static function getEnabled():Boolean {
			return enabled;
		}
		
		public static function releaseFocusOnMouseDownOutside():void{
			releaseFocus = true;
		}
		
		public static function setDefaultButton(button:Button):void {
						if(defaultButton == button){
				return;
			}
			if (defaultButton != null) {
				var _1:DisplayObject = defaultButton.emphasizedSkin;
				if(_1 != null){
					_1.visible = false;
					defaultButton.repaint();
				}
			}
			defaultButton = button;
			if (button != null) {
				_1 = button.emphasizedSkin;
				if(_1 != null){
															_1.visible = true;
					button.repaint();
				}
			}
		}
		
		public static function getDefaultButton():Button {
			return defaultButton;
		}
		
		
		
		public static function setFocus(component:InteractiveObject):void {
			if(stage == null){
				return;
			}
			if(focusOwner == component){
				if(stage.focus != component){
					stage.focus = component
				}
				return;
			}
			
			if(component == null){
				if(focusOwner != null && (focusOwner is Component)){
					Component(focusOwner).drawFocus(false);
				}
				stage.focus = focusOwner = null;
				return;
			}
			var _1:Component,_2:Component,_3:Window = null;
			var _4:DisplayObject = component;
			while(_4 != null && _4 != component.root){
				if(_1 != null && !_1.getFocusEnabled() && _2 == null && (_4 is Component)){
					_2 = Component(_4);
					if(!_2.getFocusEnabled()){
						_2 = null;
					}
				}
				if(_1 == null && (_4 is Component)){
					_1 = Component(_4);
				}
				if(_4 is Window){
					_3 = Window(_4);
					break;
				}
				_4 = _4.parent;
			}
			var activeWindow = WindowManager.getActiveWindow();
			if(activeWindow != null && activeWindow != _3 && activeWindow.getModal()){
				return;
			}
			if(_2 != null){
				_1 = _2;
			}else if((_1 is Container) && component.tabEnabled){
				_1 = null;
			}
			if(_3 != null){
				var _5:Button = _3.getDefaultButton();
				if(_5 != null){
					if(_1 is Button){
						var _6:Button = Button(_1);
						if(_6.emphasizedSkin != null){
							_5 = _6;
						}
					}
				}
				setDefaultButton(_5);
			}else if(defaultButton != null){
				_3 = null;
				_4 = defaultButton.parent;
				while(_4 != null && _4 != defaultButton.root){
					if (_4 is Window) {
						_3 = Window(_4);
						break;
					}
					_4 = _4.parent;
				}
				if(_3 != null && _3.getDefaultButton() != null){
					setDefaultButton(null);
				}
			}
			if(focusOwner != null && (focusOwner is Component) && focusOwner != _1){
				Component(focusOwner).drawFocus(false);
			}
			stage.focus = (component is TextField) || _1 == null ? component : _1;
			focusOwner = _1 != null ? _1 : component;
					}
		
		public static function getFocus():InteractiveObject {
			return focusOwner;
		}
		static function onMouseFocusChange(evt:FocusEvent):void {
						if(evt.isDefaultPrevented()){
				return;
			}
			if(evt.relatedObject == null){
				if(releaseFocus){
					lastFocusOwner = focusOwner;
					setFocus(null);
				}
				evt.preventDefault();
				return;
			}
			var _1:InteractiveObject = InteractiveObject(evt.relatedObject);
			var _2:Component,_3:Component,_4:Window;
			var _5:DisplayObject = _1;
			do{
				if(_2 != null && !_2.getFocusEnabled() && _3 == null && (_5 is Component)){
					_3 = Component(_5);
					if(!_3.getFocusEnabled()){
						_3 = null;
					}
				}
				if(_2 == null && (_5 is Component)){
					_2 = Component(_5);
				}
				if(_5 is Window){
					_4 = Window(_5);
					break;
				}
				_5 = _5.parent;
			}while(_5 != null && _5 != _1.root);
			if(_3 != null){
				_2 = _3;
			}else if((_2 is Container) && _1.tabEnabled){
				_2 = null;
			}
			if(_4 != null){
				if(WindowManager.getActiveWindow() != _4){
					WindowManager.activate(_4);
				}
				var _6:Button = _4.getDefaultButton();
				if(_6 != null){
					if(_2 is Button){
						var _7:Button = Button(_2);
						if(_7.emphasizedSkin != null){
							_6 = _7;
						}
					}
				}
				setDefaultButton(_6);
			}else if(defaultButton != null){
				_4 = null;
				_5 = defaultButton.parent;
				while(_5 != null && _5 != defaultButton.root){
					if (_5 is Window) {
						_4 = Window(_5);
						break;
					}
					_5 = _5.parent;
				}
				if(_4 != null && _4.getDefaultButton() != null){
					setDefaultButton(null);
				}
			}
			if(focusOwner != null && (focusOwner is Component) && focusOwner != _2){
				Component(focusOwner).drawFocus(false);
			}
			if(_1 is TextField){
				focusOwner = _2 != null ? _2 : _1;
				return;
			}
			focusOwner = stage.focus = _2 != null ? _2 : _1;
			evt.preventDefault();
		}
		static function onKeyFocusChange(evt:FocusEvent):void {
						if (evt.isDefaultPrevented()){
				return;
			}
			evt.preventDefault();
			if (! enabled) {
				return;
			}
			if(lastFocusOwner != null){
				if(lastFocusOwner is Component){
					Component(lastFocusOwner).setFocus();
					Component(lastFocusOwner).drawFocus(true);
				}else{
					setFocus(lastFocusOwner);
				}
				lastFocusOwner = null;
				return;
			}
			var _1:InteractiveObject = InteractiveObject(evt.relatedObject);
			var _2:DisplayObjectContainer;
			if(focusOwner != null && focusOwner.root == null){
				focusOwner = null;
			}
			if(focusOwner == null){
				_2 = DisplayObjectContainer(_1.root);
			}else{
				var _3:InteractiveObject = focusOwner;
				_2 = (focusOwner is Container) ? DisplayObjectContainer(focusOwner) : getParentContainer(focusOwner);
				while(true){
					var _4:InteractiveObject = getNextFocusComponent(_2,_3,evt.shiftKey);
					if(_4 != null){
						if(_4 is Component){
							Component(_4).setFocus();
							Component(_4).drawFocus(true);
						}else{
							setFocus(_4);
						}
						
						return;
					}
					if(_2 != focusOwner.root && !(_2 is Window)){
						_3 = _2;
						_2 = getParentContainer(_3);
					}else{
						break;
					}
				}
			}
			_4 = getNextFocusComponent(_2,null,evt.shiftKey);
			if(_4 != null){
				if(_4 is Component){
					Component(_4).setFocus();
					Component(_4).drawFocus(true);
				}else{
					setFocus(_4);
				}
				
			}
		}
		static function getParentContainer(component:InteractiveObject):DisplayObjectContainer {
			var _1:DisplayObjectContainer = component.parent;
			while(_1 != component.root){
				if(_1 is Container){
					return _1;
				}
				_1 = _1.parent;
			}
			return _1;
		}
		static function getAllTabEnabledComponents(container:DisplayObjectContainer,components:Array):Array {
			for (var _1:int = 0,_2:uint = container.numChildren; _1 < _2; _1++) {
				if (! (container.getChildAt(_1) is InteractiveObject)) {
					continue;
				}
				var _3:InteractiveObject = InteractiveObject(container.getChildAt(_1));
				if(_3 != focusOwner){
					if (! _3.visible || _3.alpha == 0) {
						continue;
					}
					if (_3.tabIndex < 0 || (! _3.tabEnabled && !((_3 is Container) && Container(_3).tabChildren))){
						continue;
					}
					if ((_3 is Component) && (! Component(_3).getFocusEnabled() || ! Component(_3).getEnabled())){
						continue;
					}
				}
				for (var _4:int = 0; _4 <= components.length; _4++) {
					if(_4 == components.length){
						components.push(_3);
						break;
					}else if(_3.tabIndex < components[_4].tabIndex){
						components.splice(_4,0,_3);
						break;
					}
				}
				if ((_3 is DisplayObjectContainer) && ! (_3 is Component) && DisplayObjectContainer(_3).tabChildren){
					getAllTabEnabledComponents(DisplayObjectContainer(_3),components);
				}
			}
			return components;
		}
		static function getNextFocusComponent(container:DisplayObjectContainer,component:InteractiveObject=null,backward:Boolean=false):InteractiveObject {
			var _1:Array = getAllTabEnabledComponents(container,[]);
						var _2:int;
			var _3:int = backward ? -1 : 1;
			if (component != null) {
				_2 = _1.indexOf(component);
				_2 += _3;
			} else {
				_2 = backward ? _1.length-1 : 0;
			}
			while(_2 >=0 && _2 < _1.length){
				var _4:InteractiveObject = _1[_2];
				if((_4 is Container) && Container(_4).tabChildren){
					_4 = getNextFocusComponent(Container(_4),null,backward);
					if(_4 != null){
						return _4;
					}
				}else{
					return _4;
				}
				_2 += _3;
			}
			return null;
		}
		
		private static function onKeyDown(evt:KeyboardEvent):void{
			if(defaultButton == null){
				return;
			}
			if(evt.keyCode != Keyboard.ENTER || evt.isDefaultPrevented()){
				return;
			}
			defaultButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false,defaultButton.mouseX,defaultButton.mouseY));
		}
	}
}

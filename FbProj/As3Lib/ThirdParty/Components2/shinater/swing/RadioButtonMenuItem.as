package shinater.swing{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class RadioButtonMenuItem extends MenuItem {
		protected var _selected:Boolean = false;
		private var _1:String;
		
		public function RadioButtonMenuItem(label:String = null,selected:Boolean = false) {
			super();
			if(label != null){
				setLabel(label);
			}
			if(selected){
				setSelected(true);
			}
		}
		protected override function init():void {
			super.init();
			setGroupName("radioGroup");
		}
		
		public function setSelected(selected:Boolean):void {
			if(_selected == selected){
				return;
			}
			_selected = selected;
			setMouseState(_mouseState);
			if(selected){
				setSelection(this);
			}
		}
		
		public function getSelected():Boolean {
			return _selected;
		}
		
		public function setGroupName(groupName:String):void {
			_1 = groupName;
		}
		
		public function getGroupName():String {
			return _1;
		}
		private function getGroup():Array {
			if(parent == null){
				return [this];
			}
			var _2:Array = [];
			for(var _3:int = 0,_4:uint = parent.numChildren; _3<_4; _3++){
				var _5:DisplayObject = parent.getChildAt(_3);
				if(_5 is RadioButtonMenuItem){
					var _6:RadioButtonMenuItem = RadioButtonMenuItem(_5);
					if(_6.getGroupName() == _1){
						_2.push(_6);
					}
				}
			}
			return _2;
		}
		private static function setSelection(menuItem:RadioButtonMenuItem):void {
			var _2:Array = menuItem.getGroup();
			for(var _3:int = 0,length = _2.length; _3 < length; _3++){
				var _4:RadioButtonMenuItem = _2[_3];
					if(_4 != menuItem && _4.getSelected()){
					_4.setSelected(false);
				}
			}
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		protected override function onMouseUp(evt:MouseEvent):void {
			if (! _enabled) {
				evt.stopImmediatePropagation();
				return;
			}
			if (! _selected) {
				_selected = true;
				setSelection(this);
				setMouseState("over");
				dispatchEvent(new Event(Event.CHANGE,false));
			} else {
				setMouseState("over");
			}
		}
		public override function setMouseState(state:String):void {
			_mouseState = state;
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"setMouseState",state)){
				return;
			}
			switch(state){
				case "up":
					gotoAndStop(_selected ? (_enabled ? 6 : 9): (_enabled ? 1 : 4));
					break;
				case "over":
					gotoAndStop(_selected ? (_enabled ? 7 : 10): (_enabled ? 2 : 5));
					break;
				case "down":
					if(!_enabled){
						return;
					}
					gotoAndStop(_selected ? 8:3);
			}
			repaint();
		}
	}
}

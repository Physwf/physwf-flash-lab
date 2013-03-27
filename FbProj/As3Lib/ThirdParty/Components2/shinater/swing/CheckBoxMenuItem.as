package shinater.swing{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class CheckBoxMenuItem extends MenuItem {
		protected var _selected:Boolean = false;
		
		public function CheckBoxMenuItem(label:String = null,selected:Boolean = false) {
			super();
			if(label != null){
				setLabel(label);
			}
			if(selected){
				setSelected(true);
			}
		}
		
		
		
		public function setSelected(selected:Boolean):void {
			if(_selected == selected){
				return;
			}
			_selected = selected;
			setMouseState(_mouseState);
		}
		
		public function getSelected():Boolean {
			return _selected;
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		protected override function onMouseUp(evt:MouseEvent):void {
			if (! _enabled) {
				evt.stopImmediatePropagation();
				return;
			}
			_selected = !_selected;
			setMouseState("over");
			dispatchEvent(new Event(Event.CHANGE,false));
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

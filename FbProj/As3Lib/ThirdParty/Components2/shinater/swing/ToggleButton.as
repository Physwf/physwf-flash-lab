package shinater.swing{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import shinater.swing.managers.StyleManager;

	
	public dynamic class ToggleButton extends Button {
		protected var _selected:Boolean = false;
		
		
		public function ToggleButton(label:String = null) {
			super();
			if(label != null){
				setLabel(label);
			}
		}
		protected override function init():void {
			super.init();
								}
		
		public function setSelected(selected:Boolean):void {
			if (_selected == selected) {
				return;
			}
			_selected = selected;
			setMouseState(_mouseState);
		}
		
		public function getSelected():Boolean {
			return _selected;
		}
		protected override function onMouseUp(evt:MouseEvent):void {
			var _1:String = _mouseState;
			if(_1 == "down"){
				onClick(evt);
			}
			super.onMouseUp(evt);
		}
		
		[Event(name = "change",type = "flash.events.Event")]
		protected function onClick(evt:MouseEvent):void {
						_selected = ! _selected;
			dispatchEvent(new Event(Event.CHANGE,false));
		}
		protected override function onKeyUp(evt:KeyboardEvent):void {
			if (evt.keyCode != Keyboard.SPACE){
				return;
			}
			onClick(null);
			super.onKeyUp(evt);
		}
		public override function setMouseState(state:String):void {
						if(! enabled && state != "disabled"){
				return;
			}
			_mouseState = state;
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"setMouseState",state)){
				return;
			}
			switch(state){
				case "up":
					gotoAndStop(_selected ? 5:1);
					break;
				case "over":
					gotoAndStop(_selected ? 6:2);
					break;
				case "down":
					gotoAndStop(_selected ? 7:3);
					break;
				case "disabled":
					gotoAndStop(_selected ? 8:4);
			}
			var _1:DisplayObject = !enabled ? getDisabledIcon() : null;
			if(_1 == null){
				_1 = getIcon();
			}
			if(this.icon != _1){
				if(this.icon != null){
					removeChild(this.icon);
				}
				if(_1 != null){
					addChild(_1);
				}
				this.icon = _1;
			}
			repaint();
		}
	}
}

package shinater.swing{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	
	public dynamic class ToolBarButton extends Button {
		protected var _enabled:Boolean = true;
		
		public function ToolBarButton(icon:DisplayObject = null, label:String = null) {
			super();
			if(icon != null){
				setIcon(icon);
			}
			if(label != null){
				setLabel(label);
			}
		}
		protected override function init():void{
			super.init();
			tabEnabled = false;
			setFocusEnabled(false);
			addEventListener(MouseEvent.CLICK,onClick,false,0,true)
		}
		public override function set enabled(value:Boolean):void {
			if (_enabled == value) {
				return;
			}
			_enabled = value;
			if(!value){
				setMouseState("disabled");
			}else{
				setMouseState(stage != null && this.hitTestPoint(stage.mouseX,stage.mouseY,true) ? "over":"up");
			}
		}
		public override function get enabled():Boolean {
			return _enabled;
		}
		protected override function onRollOut(evt:MouseEvent):void {
			if (! _enabled){
				evt.stopPropagation();
				return;
			}
			super.onRollOut(evt);
		}
		protected override function onRollOver(evt:MouseEvent):void {
			if (! _enabled){
				evt.stopPropagation();
				return;
			}
			super.onRollOver(evt);
		}
		protected override function onMouseDown(evt:MouseEvent):void {
			if (! _enabled){
				evt.stopImmediatePropagation();
				return;
			}
			super.onMouseDown(evt);
		}
		protected override function onMouseUp(evt:MouseEvent):void {
			if (! _enabled){
				evt.stopImmediatePropagation();
				return;
			}
			super.onMouseUp(evt);
		}
		protected function onClick(evt:MouseEvent):void {
			if (! _enabled){
				evt.stopImmediatePropagation();
			}
		}
		protected override function onKeyDown(evt:KeyboardEvent):void {
			if (! _enabled){
				evt.stopImmediatePropagation();
				return;
			}
			super.onKeyDown(evt);
		}
		protected override function onKeyUp(evt:KeyboardEvent):void {
			if (! _enabled){
				evt.stopImmediatePropagation();
				return;
			}
			super.onKeyUp(evt);
		}
		public override function repaint():void {
			var _1:String = getLabel();
			if(_1 != null && _1 != "" && textField != null){
				textField.visible = true;
				super.repaint();
			}else{
				if(textField != null){
					textField.visible = false;
				}
				var _2:Number = _width;
				var _3:Number = _height;
				if(icon != null){
					if(getAutoSize()){
						icon.x = _textPaddingX;
						icon.y = _textPaddingY;
						_2 = _textPaddingX*2 + icon.width;
						_3 = _textPaddingY*2 + icon.height;
					}else{
						icon.x = int((_2 - icon.width) / 2);
						icon.y = int((_3 - icon.height) / 2);
					}
				}
				if (skin != null) {
					skin.width = _2;
					skin.height = _3;
				}
				if(focusRectSkin != null){
					focusRectSkin.width = _2;
					focusRectSkin.height = _3;
				}
			}
		}
	}
}

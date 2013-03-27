package shinater.swing{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class ListCellRenderer extends ToggleButton implements ICellRenderer {
		private var _1:Component;
		private var _2:int;
		private var _3:Object;
		
		public function ListCellRenderer() {
			super();
		}
		public override function setLabelPlacement(placement:String):void {
		}
		public override function getFocusEnabled():Boolean{
			return false;
		}
		public override function getTextFormat():TextFormat {
			var _4:TextFormat = super.getTextFormat();
			if(_4 != null){
				return _4;
			}
			var _5:DisplayObjectContainer = parent;
			while(_5 != null && _5 != root){
				if(_5 is Component){
					_4 = Component(_5).getTextFormat();
					if(_4 != null){
						return _4;
					}
					if(_5 is List){
						break;
					}
				}
				_5 = _5.parent;
			}
			return null;
		}
		public override function getDisabledTextFormat():TextFormat {
			var _4:TextFormat = super.getDisabledTextFormat();
			if(_4 != null){
				return _4;
			}
			var _5:DisplayObjectContainer = parent;
			while(_5 != null && _5 != root){
				if(_5 is Component){
					_4 = Component(_5).getDisabledTextFormat();
					if(_4 != null){
						return _4;
					}
					if(_5 is List){
						break;
					}
				}
				_5 = _5.parent;
			}
			return null;
		}
		
		public function setOwner(list:Component):void {
			_1 = list;
		}
		
		public function getOwner():Component {
			return _1;
		}
		
		public function setIndex(index:int):void {
			_2 = index;
		}
		
		public function getIndex():int {
			return _2;
		}
		
		public function setData(data:Object):void {
			_3 = data;
		}
		
		public function getData():Object {
			return _3;
		}
		protected override function onMouseDown(evt:MouseEvent):void{
			_selected = ! _selected;
			super.onMouseDown(evt);
		}
		protected override function onClick(evt:MouseEvent):void {
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _4:Number = _width;
			var _5:Number = _height;
			var _6:Number = _textPaddingX;
			if(icon != null){
				icon.x = _6;
				icon.y = Math.ceil((_5-icon.height)/2);
				_6 += _5;
			}
			textField.x = _6;
			textField.width = _4 - _textPaddingX*2;
			var _7:String = getLabel();
			if(_7 != null){
				textField.htmlText = _7;
				var _8:TextFormat = enabled ? getTextFormat() : getDisabledTextFormat();
				if(_8 != null){
					textField.setTextFormat(_8);
				}
			}
			textField.y = Math.ceil((_5-textField.height)/2);
			skin.width = _4;
			skin.height = _5;
			if(focusRectSkin != null){
				focusRectSkin.width = _4;
				focusRectSkin.height = _5;
			}
		}
	}
}

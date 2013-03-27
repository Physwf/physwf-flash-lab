package shinater.swing{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class TreeCellRenderer extends ToggleButton implements ITreeCellRenderer {
		private var _1:Component;
		private var _2:int;
		private var _3:Object;
		private var _4:DisplayObject;
		private var _5:DisplayObject;
		private var _6:DisplayObject;
		private var _7:int;
		private var _8:Boolean;
		private var _9:Boolean;
		private var _10:int = int.MIN_VALUE;
		
		public static var indentation:int = 16;
		private static var defaultOpenIcon:Class;
		
		public static function setDefaultOpenIcon(iconClass:Class):void{
			defaultOpenIcon = iconClass;
		}
		private static var defaultClosedIcon:Class;
		
		public static function setDefaultClosedIcon(iconClass:Class):void{
			defaultClosedIcon = iconClass;
		}
		private static var defaultLeafIcon:Class;
		
		public static function setDefaultLeafIcon(iconClass:Class):void{
			defaultLeafIcon = iconClass;
		}
		
		public var disclosureButton:ToggleButton;
		private var _11:String = "up";
		
		public function TreeCellRenderer() {
			super();
		}
		protected override function init():void{
			super.init();
			
			addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove,false,0,true);
		}
		public override function setLabelPlacement(placement:String):void {
		}
		public override function getAutoSize():Boolean{
			return true;
		}
		public override function getFocusEnabled():Boolean{
			return false;
		}
		public override function getTextFormat():TextFormat {
			var _12:TextFormat = super.getTextFormat();
			if(_12 != null){
				return _12;
			}
			var _13:DisplayObjectContainer = parent;
			while(_13 != null && _13 != root){
				if(_13 is Component){
					_12 = Component(_13).getTextFormat();
					if(_12 != null){
						return _12;
					}
					if(_13 is Tree){
						break;
					}
				}
				_13 = _13.parent;
			}
			return null;
		}
		public override function getDisabledTextFormat():TextFormat {
			var _12:TextFormat = super.getDisabledTextFormat();
			if(_12 != null){
				return _12;
			}
			var _13:DisplayObjectContainer = parent;
			while(_13 != null && _13 != root){
				if(_13 is Component){
					_12 = Component(_13).getDisabledTextFormat();
					if(_12 != null){
						return _12;
					}
					if(_13 is Tree){
						break;
					}
				}
				_13 = _13.parent;
			}
			return null;
		}
		
		public function setOwner(tree:Component):void {
			_1 = tree;
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
		
		public function setOpenIcon(icon:DisplayObject):void{
			_4 = icon;
			if(_9){
				setIcon(icon);
			}
		}
		
		public function getOpenIcon():DisplayObject{
			if(_4 == null && defaultOpenIcon != null){
				_4 = DisplayObject(new defaultOpenIcon());
			}
			return _4;
		}
		
		public function setClosedIcon(icon:DisplayObject):void{
			_5 = icon;
			if(_8 && !_9){
				setIcon(icon);
			}
		}
		
		public function getClosedIcon():DisplayObject{
			if(_5 == null && defaultClosedIcon != null){
				_5 = DisplayObject(new defaultClosedIcon());
			}
			return _5;
		}
		
		public function setLeafIcon(icon:DisplayObject):void{
			_6 = icon;
			if(!_8){
				setIcon(icon);
			}
		}
		
		public function getLeafIcon():DisplayObject{
			if(_6 == null && defaultLeafIcon != null){
				_6 = DisplayObject(new defaultLeafIcon());
			}
			return _6;
		}
		
		public function setDepth(depth:int):void{
			if(_7 == depth){
				return;
			}
			_7 = depth;
			repaint();
		}
		
		public function getDepth():int{
			return _7;
		}
		
		public function setIsBranch(isBranch:Boolean):void{
			_8 = isBranch;
			if(isBranch){
				setIcon(_9 ? getOpenIcon() : getClosedIcon());
			}else{
				_9 = false;
				setIcon(getLeafIcon());
			}
		}
		
		public function getIsBranch():Boolean{
			return _8;
		}
		
		public function setExpanded(expanded:Boolean):void{
			setIsOpen(expanded);
		}
		
		public function getExpanded():Boolean{
			return getIsOpen();
		}
		
		public function setIsOpen(open:Boolean):void{
			if(!_8){
				return;
			}
			if(_9 == open){
				return;
			}
			_9 = open;
			disclosureButton.setSelected(open);
			setIcon(open ? getOpenIcon() : getClosedIcon());
		}
		
		public function getIsOpen():Boolean{
			return _9;
		}
		protected function onDisclosureButtonDown(evt:MouseEvent):void{
			setIsOpen(!disclosureButton.getSelected());
			_10 = int.MIN_VALUE;
		}
		protected function onMouseMove(evt:MouseEvent):void{
			if(!disclosureButton.visible){
				return;
			}
			if(disclosureButton.hitTestPoint(evt.stageX,evt.stageY,true)){
				if(_11 == "up"){
					_11 = "over";
					disclosureButton.setMouseState(_11);
				}
				if(_mouseState != "up"){
					setMouseState("up");
				}
			}else{
				if(_11 != "up"){
					_11 = "up";
					disclosureButton.setMouseState(_11);
				}
				if(_mouseState == "up"){
					setMouseState("over");
				}
			}
		}
		protected override function onMouseDown(evt:MouseEvent):void{
			if(disclosureButton.visible && disclosureButton.hitTestPoint(evt.stageX,evt.stageY,true)){
				_11 = "down";
				disclosureButton.setMouseState(_11);
				onDisclosureButtonDown(evt);
				return;
			}
			if(!evt.ctrlKey && !evt.shiftKey){
				var _12:int = getTimer();
				if(_12 - _10 <= 500){
					onDisclosureButtonDown(evt);
					return;
				}
				_10 = _12;
			}
			if((_1 is Tree) && !Tree(_1).getSelectable()){
				return;
			}
			_selected = ! _selected;
			super.onMouseDown(evt);
		}
		protected override function onMouseUp(evt:MouseEvent):void{
			if(disclosureButton.visible && disclosureButton.hitTestPoint(evt.stageX,evt.stageY,true)){
				_11 = "over";
				disclosureButton.setMouseState(_11);
				return;
			}
			super.onMouseUp(evt);
		}
		protected override function onRollOver(evt:MouseEvent):void{
			if(disclosureButton.visible && disclosureButton.hitTestPoint(evt.stageX,evt.stageY,true)){
				return;
			}
			super.onRollOver(evt);
		}
		protected override function onRollOut(evt:MouseEvent):void{
			if (! mouseEnabled){
				return;
			}
			if(_11 != "up"){
				_11 = "up";
				disclosureButton.setMouseState(_11);
			}
			if(_mouseState != "up"){
				super.onRollOut(evt);
			}
		}
		protected override function onClick(evt:MouseEvent):void {
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _12:Number = _height;
			disclosureButton.visible = _8;
			disclosureButton.y = Math.ceil((_12-disclosureButton.height)/2);
			var _13:Number = _textPaddingX;
			if(icon != null){
				icon.x = _13;
				icon.y = Math.ceil((_12-icon.height)/2);
				_13 += _12;
			}
			textField.x = _13;
			textField.autoSize = TextFieldAutoSize.LEFT;
			var _14:String = getLabel();
			if(_14 != null){
				textField.htmlText = _14;
				var _15:TextFormat = enabled ? getTextFormat() : getDisabledTextFormat();
				if(_15 != null){
					textField.setTextFormat(_15);
				}
			}
			textField.y = Math.ceil((_12-textField.height)/2);
			skin.x = _13 - _textPaddingY*2;
			skin.width = textField.width + _textPaddingY*4;
			skin.height = _12;
			if(focusRectSkin != null){
				focusRectSkin.x = skin.x;
				focusRectSkin.width = skin.width;
				focusRectSkin.height = _12;
			}
			this.x = indentation * getDepth();
		}
	}
}

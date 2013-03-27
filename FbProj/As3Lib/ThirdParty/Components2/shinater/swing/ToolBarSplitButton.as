package shinater.swing{
	import flash.display.DisplayObject;
	import flash.text.TextFormat;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import shinater.swing.managers.PopUpManager;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class ToolBarSplitButton extends Component {
		protected var _width:Number;
		protected var _height:Number;
		protected var _autoSize:Boolean = false;
		
		public var button:ToolBarButton;
		
		public var downArrow:Button;
		
		public var dropdown:Component;
		
		public function ToolBarSplitButton(icon:DisplayObject = null, label:String = null) {
			super();
			if(icon != null){
				setIcon(icon);
			}
			if(label != null){
				setLabel(label);
			}
		}
		protected override function init():void{
			_width = super.width;
			_height = super.height;
			scaleX = scaleY = 1;
			super.init();
			tabEnabled = false;
			setFocusEnabled(false);
			button.tabEnabled = false;
			button.setFocusEnabled(false);
			button.addEventListener(MouseEvent.ROLL_OVER,onRollOver,false,1,true);
			button.addEventListener(MouseEvent.ROLL_OUT,onRollOut,false,1,true);
			downArrow.tabEnabled = false;
			downArrow.setFocusEnabled(false);
			downArrow.addEventListener(MouseEvent.ROLL_OVER,onRollOver,false,1,true);
			downArrow.addEventListener(MouseEvent.ROLL_OUT,onRollOut,false,1,true);
			downArrow.addEventListener(MouseEvent.MOUSE_DOWN,onDownArrowDown,false,0,true);
			downArrow.addEventListener(MouseEvent.MOUSE_DOWN,onDownArrowClick,false,0,true);
			setDropDownComponent(dropdown);
			repaint();
		}
		public override function set enabled(value:Boolean):void{
			super.enabled = value;
			button.enabled = value;
			downArrow.enabled = value;
		}
		public override function set mouseEnabled(value:Boolean):void{
			button.mouseEnabled = value;
						if(value){
				if(stage!=null && this.hitTestPoint(stage.mouseX,stage.mouseY,true)){
					button.setMouseState("over")
					downArrow.setMouseState("over");
				}else{
					button.setMouseState("up")
					downArrow.setMouseState("up");
				}
			}
			super.mouseEnabled = value;
			mouseChildren = value;
		}
		public override function set width(value:Number):void {
			if(_width == value){
				return;
			}
			_width = value;
			repaint();
		}
		public override function set height(value:Number):void {
			if(_height == value){
				return;
			}
			_height = value;
			repaint();
		}
		public override function setSize(width:Number,height:Number):void {
			if(_width == width && _height == height){
				return;
			}
			_width = width;
			_height = height;
			repaint();
		}
		public override function setTextFormat(textFormat:TextFormat):void {
			button.setTextFormat(textFormat);
		}
		public override function getTextFormat():TextFormat {
			return button.getTextFormat();
		}
		public override function setDisabledTextFormat(textFormat:TextFormat):void{
			button.setDisabledTextFormat(textFormat);
		}
		public override function getDisabledTextFormat():TextFormat{
			return button.getDisabledTextFormat();
		}
		
		public function setIcon(icon:DisplayObject):void {
			button.setIcon(icon);
		}
		
		public function getIcon():DisplayObject {
			return button.getIcon();
		}
		
		public function setDisabledIcon(icon:DisplayObject):void{
			button.setDisabledIcon(icon);
		}
		
		public function getDisabledIcon():DisplayObject{
			return button.getDisabledIcon();
		}
		
		public function setLabel(label:String):void {
			button.setLabel(label);
			repaint();
		}
		
		public function getLabel():String {
			return button.getLabel();
		}
		
		public function setLabelPlacement(placement:String):void {
			button.setLabelPlacement(placement);
			repaint();
		}
		
		public function getLabelPlacement():String {
			return button.getLabelPlacement();
		}
		
		public function setAutoSize(auto:Boolean):void {
			if(_autoSize == auto){
				return;
			}
			_autoSize = auto;
			repaint();
		}
		
		public function getAutoSize():Boolean {
			return _autoSize;
		}
		
		public function setDropDownComponent(component:Component):void{
			if(dropdown != null){
				dropdown.removeEventListener("hide", onDropdownHide);
				if(dropdown.parent != null){
					dropdown.parent.removeChild(dropdown);
				}
			}
			dropdown = component;
			if(dropdown != null){
				dropdown.addEventListener("hide",onDropdownHide,false,0,true);
				dropdown.visible = false;
			}
		}
		
		public function getDropDownComponent():Component{
			return dropdown;
		}
		private function showPopup():void {
			dropdown.repaint();
			var _1:Boolean = (parent is ToolBar) && ToolBar(parent).getDirection() == ToolBar.VERTICAL;
			var _2:Point = _1 ? new Point(width,0) : new Point(0,height);
			_2 = localToGlobal(_2);
			if(_2.x + dropdown.width > stage.stageWidth){
				_2.x = Math.max(0,_2.x+(_1 ? -width : width)-dropdown.width);
			}
			if(_2.y + dropdown.height > stage.stageHeight){
				_2.y = Math.max(0,_2.y+(_1 ? height : -height)-dropdown.height);
			}
			_2 = globalToLocal(_2);
			PopUpManager.show(dropdown,this,_2.x,_2.y);
			mouseEnabled = false;
		}
		protected function onRollOver(evt:MouseEvent):void{
			if(evt.currentTarget == button){
				downArrow.setMouseState("over");
			}else{
				button.setMouseState("over");
			}
		}
		protected function onRollOut(evt:MouseEvent):void{
			if(hitTestPoint(evt.stageX,evt.stageY,true)){
				evt.stopImmediatePropagation();
				return;
			}
			if(evt.currentTarget == button){
				downArrow.setMouseState("up");
			}else{
				button.setMouseState("up");
			}
		}
		protected function onDownArrowDown(evt:MouseEvent):void{
			if(dropdown == null){
				return;
			}
			showPopup();
		}
		protected function onDownArrowClick(evt:MouseEvent):void{
			evt.stopPropagation();
		}
		protected function onDropdownHide(evt:Event):void {
			mouseEnabled = true;
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			if(getAutoSize()){
				button.setAutoSize(true);
				downArrow.x = button.x + button.width;
				downArrow.height = button.height;
			}else{
				button.setAutoSize(false);
				button.setSize(_width-downArrow.width,_height);
				downArrow.x = button.x + button.width;
				downArrow.height = _height;
			}
		}
	}
}

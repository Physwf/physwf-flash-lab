package shinater.swing{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import shinater.swing.managers.StyleManager;
	
	
	public dynamic class Label extends Component {
		
		public var textField:TextField;
		
		public function Label(text:String = null) {
			super();
						if(text != null){
				setText(text);
			}
		}
		public override function get x():Number{
			return super.x + textField.x;
		}
		public override function set x(value:Number):void{
			super.x = value - textField.x;
		}
		public override function set width(value:Number):void {
			textField.width = value;
		}
		public override function set height(value:Number):void {
			textField.height = value;
		}
		public override function setSize(width:Number, height:Number):void{
			textField.width = width;
			textField.height = height;
		}
		public override function set enabled(value:Boolean):void{
			super.enabled = value;
			repaint();
		}
		public override function get tabEnabled():Boolean {
			return false;
		}
		public override function get tabChildren():Boolean {
			return false;
		}
		public override function getFocusEnabled():Boolean {
			return false;
		}
		
		public function setText(text:String):void {
			textField.text = text;
			repaint();
		}
		
		public function getText():String {
			return textField.text;
		}
		
		public function setHtmlText(html:String):void {
			textField.htmlText = html;
		}
		
		public function getHtmlText():String {
			return textField.htmlText;
		}
		
		public function setTextColor(color:uint):void {
			textField.textColor = color;
		}
		
		public function getTextColor():uint {
			return textField.textColor;
		}
		
		public function setAutoSize(autoSize:String):void {
			if(autoSize == TextFieldAutoSize.NONE || autoSize == TextFieldAutoSize.LEFT){
				textField.x = 0;
			}
			textField.autoSize = autoSize;
		}
		
		public function getAutoSize():String {
			return textField.autoSize;
		}
		
		public function setAlignment(alignment:String):void {
			setAutoSize(alignment);
		}
		
		public function getAlignment():String {
			return getAutoSize();
		}
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _1:TextFormat = enabled ? getTextFormat() : getDisabledTextFormat();
			if(_1 != null){
				textField.setTextFormat(_1);
			}
		}
	}
}

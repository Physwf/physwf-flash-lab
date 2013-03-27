package shinater.swing{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import shinater.swing.managers.StyleManager;
	
	
	public dynamic class ToolTip extends Component {
		private var _1:String;
		private var _2:Component;
		protected var _textPaddingX:Number = 0;
		protected var _textPaddingY:Number = 0;
		
		public var textField:TextField;
		
		public var skin:Sprite;
				
		public function ToolTip() {
			super();
		}
		protected override function init():void {
			super.init();
			_textPaddingX = textField.x;
			_textPaddingY = textField.y;
			mouseEnabled = false;
			textField.autoSize = TextFieldAutoSize.LEFT;
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
		
		public function setTipText(text:String):void {
			_1 = text;
			repaint();
		}
		
		public function getTipText():String {
			return _1;
		}
		
		public function setComponent(owner:Component):void {
			_2 = owner;
		}
		
		public function getComponent():Component {
			return _2;
		}
		
		[Event(name = "show",type = "flash.events.Event")]
		
		[Event(name = "hide",type = "flash.events.Event")]
		public override function repaint():void {
			if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
									textField.htmlText = _1;
			var _3:TextFormat = getTextFormat();
			if(_3 != null){
				textField.setTextFormat(_3);
			}
			skin.width = textField.width + _textPaddingX * 2;
			skin.height = textField.height + _textPaddingY * 2;
		}
	}
}

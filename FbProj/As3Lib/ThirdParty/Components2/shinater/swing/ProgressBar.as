package shinater.swing{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import shinater.swing.managers.StyleManager;
	
	public dynamic class ProgressBar extends Component {
		
		public static const VERTICAL:String = "vertical";
		
		public static const HORIZONTAL:String = "horizontal";
		
		public static const LEFT:String = "left";
		
		public static const RIGHT:String = "right";
		private var _1:String = HORIZONTAL;
		private var _2:String = RIGHT;
				private var _3:Boolean = false;
		private var _4:Number = 0;
		private var _5:Number = 100;
		private var _6:Number = 0;
		private var _7:Number = 0;
		private var _8:Number;
		private var _9:Number;
		protected var _barPaddingX:Number = 0;
		protected var _barPaddingY:Number = 0;
		
		public var barSkin:Sprite;
		
		public var maskSkin:Sprite;
				
		public var trackSkin:Sprite;
				
		public function ProgressBar(min:Number = 0,max:Number = 100) {
			super();
			_4 = min;
			_5 = max;
		}
		protected override function init():void {
			if (rotation == -90) {
				_1 = VERTICAL;
				_8 = super.height;
				_9 = super.width;
			}else{
				_8 = super.width;
				_9 = super.height;
			}
			scaleX = scaleY = 1;
			super.init();
			_barPaddingX = barSkin.x;
			_barPaddingY = barSkin.y;
			repaint();
		}
		public override function set y(value:Number):void {
			super.y = _1 == HORIZONTAL ? value: value + _8;
		}
		public override function get y():Number {
			return _1 == HORIZONTAL ? super.y : super.y - _8;
		}
		public override function set height(value:Number):void {
			if (_1 == HORIZONTAL) {
				if(_9 == value){
					return;
				}
				_9 = value;
			} else {
				if(_8 == value){
					return;
				}
				_8 = value;
			}
			repaint();
		}
		public override function get height():Number {
			return _1 == HORIZONTAL ? _9 : _8;
		}
		public override function set width(value:Number):void {
			if (_1 == HORIZONTAL) {
				if(_8 == value){
					return;
				}
				_8 = value;
			} else {
				if(_9 == value){
					return;
				}
				_9 = value;
			}
			repaint();
		}
		public override function get width():Number {
			return _1 == HORIZONTAL ? _8 : _9;
		}
		public override function setSize(width:Number, height:Number):void {
			if (_1 == HORIZONTAL) {
				if(_8 == width && _9 == height){
					return;
				}
				_8 = width;
				_9 = height;
			} else {
				if(_8 == height && _9 == width){
					return;
				}
				_8 = height;
				_9 = width;
			}
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
		
		public function setOrientation(orientation:String):void {
			if (_1 == orientation) {
				return;
			}
			_1 = orientation;
			if (orientation == HORIZONTAL) {
				rotation = 0;
				super.y = super.y - _8;
			} else {
				rotation = -90;
				super.y = super.y + _8;
			}
		}
		
		public function getOrientation():String {
			return _1;
		}
		
		public function setDirection(direction:String):void {
			_2 = direction;
			repaint();
		}
		
		public function getDirection():String {
			return _2;
		}
		
		public function setIndeterminate(value:Boolean):void {
			if (_3 == value) {
				return;
			}
			_3 = value;
			if (value) {
				var _10:Number = 24;
				try {
					_10 = stage.frameRate;
				} catch (e:Error) {
				}
				_7 = setInterval(repaint,1000/_10);
			} else {
				clearInterval(_7);
				repaint();
			}
		}
		
		public function getIndeterminate():Boolean {
			return _3;
		}
		
		public function setMinimum(minimum:Number):void {
			_4 = minimum;
			if (_5 < minimum) {
				_5 = minimum;
			}
			if (_6 < minimum){
				_6 = minimum;
			}
			repaint();
		}
		
		public function getMinimum():Number {
			return _4;
		}
		
		public function setMaximum(maximum:Number):void {
			if (maximum < _4) {
				return;
			}
			_5 = maximum;
			if(_6 > maximum){
				_6 = maximum;
			}
			repaint();
		}
		
		public function getMaximum():Number {
			return _5;
		}
		
		public function setValue(value:Number):void {
			value = Math.max(_4,Math.min(_5,value));
			if (_6 == value) {
				return;
			}
			_6 = value;
			repaint();
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false));
		}
		
		public function getValue():Number {
			return _6;
		}
		
		public function getPercentComplete():Number {
			return (_6 - _4)/(_5 - _4)*100;
		}
		
		public function reset():void {
			_6 = _4;
			repaint();
		}
		
		[Event(name = "progress",type = "flash.events.ProgressEvent")]
		
		
		
		public override function repaint():void {
						if(StyleManager.getEnabled() && StyleManager.callMethod(this,"repaint")){
				return;
			}
			var _10:Number = _8;
			var _11:Number = _9;
			trackSkin.width = _10;
			trackSkin.height = _11;
			_10 -= _barPaddingX * 2;
			_11 -= _barPaddingY * 2;
			if (maskSkin != null) {
				maskSkin.width = _10;
				maskSkin.height = _11;
			}
			barSkin.height = _11;
			if (! _3) {
				barSkin.width = int(_10 * (_6 - _4)/(_5 - _4));
				barSkin.x = _2 == RIGHT ? _barPaddingX:_10 + _barPaddingX - barSkin.width;
			} else {
								barSkin.width = int(_10 * 0.2);
				var _12:Number = int(barSkin.width*0.1);
				barSkin.x =_2 == RIGHT ? (barSkin.x >= _10 ? -barSkin.width : barSkin.x+_12) : (barSkin.x <= 0 ? _10 : barSkin.x-_12);
			}
		}
	}
}

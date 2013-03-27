package shinater.swing{
	import flash.display.DisplayObject;

	
	public dynamic class Container extends Component {
		
		public function Container() {
			super();
		}
		
		
		
		
		public function getComponents():Array {
			var _1:Array = [];
			for (var _2:int = 0; _2<numChildren; _2++) {
				var _3:DisplayObject = getChildAt(_2);
				if (_3 is Component) {
					_1.push(_3);
				}
			}
			return _1;
		}
		
		
		
		
	}
}

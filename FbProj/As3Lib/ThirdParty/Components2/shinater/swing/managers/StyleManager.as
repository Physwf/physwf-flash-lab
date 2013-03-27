package shinater.swing.managers{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedSuperclassName;
	import shinater.swing.Component;
	
	public class StyleManager {
		private static var enabled:Boolean = false;
		
		public static function setEnabled(enabled:Boolean):void {
			StyleManager.enabled = enabled;
		}
		
		public static function getEnabled():Boolean {
			return enabled;
		}
		public static function callDeclaredMethod(component:Object,methodName:String,... args):Boolean {
			var _1:Class = component is Class ? Class(component) : component["constructor"] as Class;
			if(_1 != null && _1.prototype.hasOwnProperty(methodName)){
				var _2:Function = _1.prototype[methodName];
				_2.apply(component,args);
				return true;
			}
			return false;
		}
		public static function callMethod(component:Object,methodName:String,... args):Boolean {
			var _1:Class = component is Class ? Class(component) : component["constructor"] as Class;
			if(_1 != null){
				var _2:Function = _1.prototype[methodName];
				if (_2 != null) {
					_2.apply(component,args);
					return true;
				}
			}
			return false;
		}
		
	}
}

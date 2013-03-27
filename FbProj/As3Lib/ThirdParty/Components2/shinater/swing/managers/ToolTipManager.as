package shinater.swing.managers{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import fl.transitions.easing.None;
	import shinater.swing.Component;
	import shinater.swing.ToolTip;
	import shinater.transitions.Tween;
	
	public class ToolTipManager {
		private static var enabled:Boolean = true;
		private static var initialDelay:Number = 750;
		private static var initialTimeout:Number;
		private static var reshowDelay:Number = 250;
		private static var reshowTime:Number;
		private static var dismissDelay:Number = 4000;
		private static var tween:Tween;
		private static var postToolTip:ToolTip;
		private static var currentToolTip:ToolTip;
		private static var defaultToolTip:ToolTip;
		private static var stage:Stage;
		
		public static function setEnabled(enabled:Boolean):void {
			ToolTipManager.enabled = enabled;
		}
		
		public static function getEnabled():Boolean {
			return enabled;
		}
		
		public static function setInitialDelay(milliseconds:Number):void {
			initialDelay = milliseconds;
		}
		
		public static function getInitialDelay():Number {
			return initialDelay;
		}
		
		public static function setDismissDelay(milliseconds:Number):void {
			dismissDelay = milliseconds;
		}
		
		public static function getDismissDelay():Number {
			return dismissDelay;
		}
		
		public static function setReshowDelay(milliseconds:Number):void{
			reshowDelay = milliseconds
		}
		
		public static function getReshowDelay():Number{
			return reshowDelay;
		}
		
		public static function setDefaultToolTip(toolTip:ToolTip):void{
			defaultToolTip = toolTip;
		}
		
		public static function getDefaultToolTip():ToolTip {
			if(defaultToolTip == null){
				defaultToolTip = new ToolTip();
			}
			return defaultToolTip;
		}
		
		public static function register(component:Component):void {
			component.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver,false,0,true);
			component.addEventListener(MouseEvent.ROLL_OUT,onMouseOut,false,0,true);
		}
		
		public static function unregister(component:Component):void {
			component.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			component.removeEventListener(MouseEvent.ROLL_OUT,onMouseOut);
		}
		private static function onMouseOver(evt:MouseEvent):void {
			if (! enabled) {
				return;
			}
			if (evt.buttonDown) {
				return;
			}
			var _1:Component = Component(evt.currentTarget);
			if (stage == null) {
				stage = _1.stage;
				stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown,true,0,true);
			}
			if(postToolTip != null && _1.contains(postToolTip.getComponent())){
				return;
			}
			var _2:Boolean;
			if(currentToolTip != null){
				if(_1.contains(currentToolTip.getComponent())){
					return;
				}
				hide(currentToolTip);
				_2 = true;
			}else{
				_2 = getTimer() <= reshowTime;
			}
			clearTimeout(initialTimeout);
			postToolTip = _1.createToolTip();
			initialTimeout = setTimeout(show,_2 ? reshowDelay : initialDelay,postToolTip,_1);
		}
		private static function onMouseOut(evt:MouseEvent):void {
			if (! enabled) {
				return;
			}
			clearTimeout(initialTimeout);
			if (postToolTip != null) {
				postToolTip = null;
			}else if (currentToolTip != null) {
				hide(currentToolTip);
				reshowTime = getTimer() + reshowDelay;
			}
		}
		private static function onMouseDown(evt:MouseEvent):void {
			if (! enabled) {
				return;
			}
			clearTimeout(initialTimeout);
			if (currentToolTip != null) {
				if (tween != null && tween.isPlaying) {
					tween.stop();
				}
				currentToolTip.alpha = 0;
				if (currentToolTip.parent != null) {
					currentToolTip.parent.removeChild(currentToolTip);
				}
				currentToolTip = null;
			}
		}
		static function show(toolTip:ToolTip,component:Component):void {
			var _1:DisplayObjectContainer = DisplayObjectContainer(component.root);
			_1.addChild(toolTip);
			var _2:Number = Math.max(0,Math.min(stage.stageWidth - toolTip.width,stage.mouseX));
			var _3:Number = Math.max(0,Math.min(stage.stageHeight - toolTip.height,stage.mouseY + 19));
			_2 = int(_2);
			_3 = int(_3);
			toolTip.setLocation(_2,_3);
			toolTip.setTipText(component.getToolTipText());
			if (tween == null) {
				tween = new Tween(toolTip,"alpha",None.easeNone,0,1,0.25,true);
			} else {
				tween.obj = toolTip;
				tween.begin = toolTip.alpha < 1 ? toolTip.alpha : 0;
				tween.finish = 1;
				tween.start();
			}
			toolTip.dispatchEvent(new Event("show"));
			postToolTip = null;
			currentToolTip = toolTip;
			initialTimeout = setTimeout(hide,dismissDelay,toolTip);
		}
		static function hide(toolTip:ToolTip):void {
			if(tween == null){
				return;
			}
			if (tween.isPlaying) {
				tween.stop();
			}
			if (toolTip.alpha > 0){
				tween.obj = toolTip;
				tween.begin = toolTip.alpha;
				tween.finish = 0;
				tween.start();
				toolTip.dispatchEvent(new Event("hide"));
			}
			reshowTime = -1;
			if(currentToolTip == toolTip){
				currentToolTip = null;
			}
		}
	}

}

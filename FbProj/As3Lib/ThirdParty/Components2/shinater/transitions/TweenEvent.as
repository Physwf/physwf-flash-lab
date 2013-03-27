package shinater.transitions{
	import flash.events.Event;
	import flash.events.TimerEvent;

	
	public class TweenEvent extends Event {
		
		public static const MOTION_START:String = "motionStart";
		
		public static const MOTION_STOP:String = "motionStop";
		
		public static const MOTION_FINISH:String = "motionFinish";
		
		public static const MOTION_CHANGE:String = "motionChange";
		
		public static const MOTION_RESUME:String = "motionResume";
		
		public static const MOTION_LOOP:String = "motionLoop";
		
		public var time:Number = NaN;
		
		public var position:Number = NaN;
		var timerEvent:TimerEvent;
		
		public function TweenEvent(type:String, time:Number, position:Number, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.time = time;
			this.position = position;
		}
		
		public function updateAfterEvent():void {
			if (timerEvent == null) {
				return;
			}
			timerEvent.updateAfterEvent();
		}
		public override function clone():Event {
			return new TweenEvent(this.type, this.time, this.position, this.bubbles, this.cancelable);
		}
	}
}

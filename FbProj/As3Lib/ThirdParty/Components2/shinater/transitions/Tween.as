
package shinater.transitions{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	
	public class Tween extends EventDispatcher {
		private static var _mc:MovieClip = new MovieClip();
		
		[Event(name = "motionChange",type = "fl.transitions.TweenEvent")]
		
		[Event(name = "motionFinish",type = "fl.transitions.TweenEvent")]
		
		[Event(name = "motionLoop",type = "fl.transitions.TweenEvent")]
		
		[Event(name = "motionResume",type = "fl.transitions.TweenEvent")]
		
		[Event(name = "motionStart",type = "fl.transitions.TweenEvent")]
		
		[Event(name = "motionStop",type = "fl.transitions.TweenEvent")]
		
		public var isPlaying:Boolean = false;
		
		public var obj:Object = null;
		
		public var prop:String = "";
		
		public var func:Function = function (t:Number, b:Number, c:Number, d:Number):Number { return c*t/d + b; };
		
		public var begin:Number = NaN;
		
		public var useSeconds:Boolean = false;
		
		public var looping:Boolean = false;
		public var change:Number = NaN;
		public var prevTime:Number = NaN;
		public var prevPos:Number = NaN;
				private var _1:Number = NaN;
		private var _2:Number = NaN;
		private var _3:Number = NaN;
		private var _4:Number = NaN;
		private var _5:Timer = null;
		private var _6:TimerEvent = null;
		private var _7:Number = NaN;
		
		public function get finish():Number {
			return begin + change;
		}
		public function set finish(value:Number):void {
			change = value - begin;
		}
		
		public function get duration():Number {
			return _1;
		}
		public function set duration(value:Number):void {
			_1 = (value <= 0) ? Infinity : value;
		}
		
		public function get time():Number {
			return _2;
		}
		public function set time(value:Number):void {
			prevTime = _2;
			if (value > duration) {
				if (looping) {
					rewind(value - _1);
					update();
					dispatchEvent(new TweenEvent(TweenEvent.MOTION_LOOP,_2,_3));
				} else {
					if (useSeconds) {
						_2 = _1;
						update();
					}
					stop();
					dispatchEvent(new TweenEvent(TweenEvent.MOTION_FINISH,_2,_3));
				}
			} else {
				if (value < 0) {
					rewind();
				} else {
					_2 = value;
				}
				update();
			}
		}
		private function update():void {
			position = func(_2,begin,change,_1);
					}
		
		public function get position():Number {
			return _3;
		}
		public function set position(value:Number):void {
			prevPos = _3;
			_3 = value;
			if (prop != null && prop.length && obj.hasOwnProperty(prop)) {
				obj[prop] = value;
			}
			var _8:TweenEvent = new TweenEvent(TweenEvent.MOTION_CHANGE,_2,_3);
			_8.timerEvent = _6;
			dispatchEvent(_8);
		}
		
		public function get FPS():Number {
			return _4;
		}
		public function set FPS(value:Number):void {
			var _8:Boolean = isPlaying;
			stopEnterFrame();
			_4 = value;
			if (_8) {
				startEnterFrame();
			}
		}
		private function fixTime():void {
			if (useSeconds) {
				_7 = getTimer() - _2 * 1000;
			}
		}
		
		function Tween(obj:Object, prop:String, func:Function, begin:Number, finish:Number, duration:Number, useSeconds:Boolean=false, fps:Number = undefined) {
			this.obj = obj;
			this.prop = prop;
			if (func != null) {
				this.func = func;
			}
			this.begin = begin;
			this.position = begin;
			this.duration = duration;
			this.useSeconds = useSeconds;
			this.finish = finish;
			_4 = fps;
			start();
		}
		
		public function start():void {
			_2 = 0;
			_3 = begin;
			fixTime();
			startEnterFrame();
			dispatchEvent(new TweenEvent(TweenEvent.MOTION_START,_2,_3));
		}
		
		public function stop():void {
			stopEnterFrame();
			dispatchEvent(new TweenEvent(TweenEvent.MOTION_STOP,_2,_3));
		}
		
		public function resume():void {
			fixTime();
			startEnterFrame();
			dispatchEvent(new TweenEvent(TweenEvent.MOTION_RESUME,_2,_3));
		}
		
		public function fforward():void {
			time = _1;
			fixTime();
		}
		
		public function rewind(t:Number=0):void {
			_2 = t;
			fixTime();
			update();
		}
		
		public function continueTo(finish:Number, duration:Number):void {
			begin = position;
			this.finish = finish;
			if (! isNaN(duration)) {
				this.duration = duration;
			}
			start();
		}
		
		public function yoyo():void {
			continueTo(begin, time);
		}
		private function startEnterFrame():void {
			if (isNaN(_4)) {
				_mc.addEventListener(Event.ENTER_FRAME,onEnterFrame,false,0,false);
			} else {
				var _8:Number = 1000 / _4;
				if (_5 == null) {
					_5 = new Timer(_8);
				} else {
					_5.delay = _8;
				}
				_5.addEventListener(TimerEvent.TIMER,onEnterFrame,false,0,false);
				_5.start();
			}
			isPlaying = true;
		}
		private function stopEnterFrame():void {
			if (isNaN(_4)) {
				_mc.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			} else if (_5 != null) {
				_5.removeEventListener(TimerEvent.TIMER,onEnterFrame);
				_5.stop();
			}
			isPlaying = false;
		}
		private function onEnterFrame(event:Event):void {
			_6 = event as TimerEvent;
			nextFrame();
			if (_6 != null && ! hasEventListener(TweenEvent.MOTION_CHANGE)) {
				_6.updateAfterEvent();
				_6 = null;
			}
		}
		
		public function nextFrame():void {
			if (useSeconds) {
				time = (getTimer() - _7) / 1000;
			} else {
				time = _2 + 1;
			}
		}
		
		public function prevFrame():void {
			if (! useSeconds) {
				time = _2 - 1;
			}
		}
	}
}

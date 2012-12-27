package
{
	import com.physwf.components.EM;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class EMTest extends Sprite
	{
		public function EMTest()
		{
			super();
			EM.addListener(stage,MouseEvent.CLICK,listener);
			trace(factorial(100));
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function listener(e:MouseEvent):void
		{
			var begin:uint  =getTimer();
			trace(factorial(100));
			trace(getTimer() - begin);
		}
		
		private function onEnterFrame(e:Event):void
		{
			EM.exexute();
		}
		
		private function factorial(n:Number):Number
		{
			var mul:Number = 1;
			if(n==1) return mul;
			var _n:Number = n-1;
			return mul = n* factorial(_n);
		}
	}
}
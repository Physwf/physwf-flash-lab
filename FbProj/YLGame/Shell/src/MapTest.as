package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import engine.world.objects.Map;
	
	[SWF(width="1900",height="1000",frameRate="60", backgroundColor="#0")]
	public class MapTest extends Sprite
	{
		private var map:Map;
		private var lastTime:uint;
		
		public function MapTest()
		{
			mapTest();
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		private function mapTest():void
		{
			map = new Map();
			addChild(map.view);
			map.initialize();
			map.id = 10001;
			map.load();
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			
			var delta:uint = getTimer() - lastTime;
			lastTime = getTimer();
			map.update(delta);
		}
	}
}
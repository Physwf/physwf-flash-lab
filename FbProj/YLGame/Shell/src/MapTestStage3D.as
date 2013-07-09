package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import components.map.gpu.Environment;
	
	import engine.world.objects.Map;
	
	[SWF(width="1000",height="600",frameRate="60", backgroundColor="#0")]
	public class MapTestStage3D extends Sprite
	{
		private var map:Map;
		private var lastTime:uint;
		
		public function MapTestStage3D()
		{
			stage?init(null):addEventListener(Event.ADDED_TO_STAGE,init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		private function init(e:Event):void
		{
			Environment.initialize(stage,function():void 
			{
				map = new Map();
				addChild(map.view);
				map.initialize();
				map.id = 10001;
				map.load();
				addEventListener(Event.ENTER_FRAME,onEnterFrame);
			} 
			);
		}
		
		private function onEnterFrame(e:Event):void
		{
			var delta:uint = getTimer() - lastTime;
			lastTime = getTimer();
			map.update(delta);
			Environment.render();
		}
	}
}
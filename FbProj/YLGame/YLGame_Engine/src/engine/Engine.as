package engine
{
	import flash.events.EventDispatcher;
	
	import engine.world.objects.Map;
	
	public class Engine extends EventDispatcher
	{
		public static var map:Map;
		
		public function Engine()
		{
		}
	}
}
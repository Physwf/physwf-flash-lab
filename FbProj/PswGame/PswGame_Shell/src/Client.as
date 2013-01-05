package
{
	import com.physwf.application.Application;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	[SWF(width="1000",height="600",frameRate="3")]
	public class Client extends Sprite
	{
		private var _app:Application;
		
		public function Client()
		{
			stage?init(null):addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void
		{
			_app = new Application(this);
			_app.startup();
		}
		
		private function onProgress(e:ProgressEvent):void
		{
			_app.progress = e.bytesLoaded / e.bytesTotal;
		}
	}
}
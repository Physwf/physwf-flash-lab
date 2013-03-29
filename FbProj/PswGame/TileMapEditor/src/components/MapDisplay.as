package components
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class MapDisplay extends Sprite
	{
		public static var mapDir:String;
		
		private var mGroundLayer:Sprite;
		private var mNpcLayer:Sprite;
		private var mTeleprotLayer:Sprite;
		
		public function MapDisplay()
		{
			mGroundLayer = new Sprite();
			addChild(mGroundLayer);
			mNpcLayer = new Sprite();
			addChild(mNpcLayer);
			mTeleprotLayer = new Sprite();
			addChild(mTeleprotLayer);
		}
		
		public function load(name:String):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.load(new URLRequest(mapDir+name+"/ground.jpg"));
		}
		
		private function onComplete(e:Event):void
		{
			var target:LoaderInfo = e.target as LoaderInfo;
			target.removeEventListener(Event.COMPLETE,onComplete);
			mGroundLayer.addChild(target.loader.content);
		}
	}
}
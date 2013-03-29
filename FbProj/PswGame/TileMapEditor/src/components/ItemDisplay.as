package components
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class ItemDisplay
	{
		public static var iconDir:String;
		public static var sceneDir:String;
		
		private var mIcon:Sprite;
		private var mSceneView:Sprite;
		private var mName:String;
		
		public function ItemDisplay(name:String)
		{
			mName = name;
			mIcon = new Sprite();
			
			mIcon.graphics.beginFill(0xFFFFFF*Math.random());
			mIcon.graphics.drawRect(0,0,40,40);
			mIcon.graphics.endFill();
			
			mSceneView = new Sprite();
		}
		
		public function get icon():Sprite
		{
			return mIcon;
		}
		
		public function get sceneView():Sprite
		{
			return mSceneView;
		}
		
		public function load():void
		{
			_load(mIcon,iconDir+mName);
			_load(mSceneView,sceneDir+mName);
		}
		
		private function _load(container:Sprite,url:String):void
		{
			function onCompelte(e:Event):void
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onCompelte);
				container.addChild(loader.content);
				loader.unloadAndStop(true);
			};
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompelte);
			loader.load(new URLRequest(url));
		}
	}
}
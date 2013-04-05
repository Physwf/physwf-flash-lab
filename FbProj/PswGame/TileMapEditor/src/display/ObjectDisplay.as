package display
{
	import com.physwf.components.bitmap.net.SkeletonLoader;
	import com.physwf.components.charactor.CharacterAnimation;
	import com.physwf.components.view.Animation;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;

	public class ObjectDisplay
	{
		public static var animations:Vector.<Animation> = new Vector.<Animation>();
		
		public var iconDir:String;
		public var sceneDir:String;
		
		private var mIcon:Sprite;
		private var mSceneView:Animation;
		private var mName:String;
		private var mScenceLayer:Sprite;
		
		public function ObjectDisplay(name:String)
		{
			mName = name;
			mIcon = new Sprite();
			
			mIcon.graphics.beginFill(0xFFFFFF*Math.random());
			mIcon.graphics.drawRect(0,0,40,40);
			mIcon.graphics.endFill();
		}
		
		public function get icon():Sprite
		{
			return mIcon;
		}
		
		public function get sceneView():Animation
		{
			return mSceneView;
		}
		
		public function load():void
		{
			loadIcon(mIcon,iconDir+"/"+mName);
			loadSceneView();
		}
		
		private function loadIcon(container:Sprite,url:String):void
		{
			function onCompelte(e:Event):void
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onCompelte);
				loader.content.width = 40;
				loader.content.height = 40;
				container.addChild(loader.content);
				loader.unloadAndStop(true);
				container.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			};
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompelte);
			loader.load(new URLRequest(url));
		}
		
		private function loadSceneView():void
		{
			var name:String = mName.substring(mName.lastIndexOf("/")+1,mName.lastIndexOf("."));
			var sLoader:SkeletonLoader = SkeletonLoader.getSameSkeletonLoader(sceneDir);
			mSceneView = new Animation(sLoader);
			mSceneView.gotoAndPlay("1");
			animations.push(mSceneView);
		}
		
		protected function onMouseDown(e:MouseEvent):void
		{
			MapEditor.editor.dragItem = mSceneView;
			if(mSceneView)
			{
				loadSceneView();
			}
		}
	}
}
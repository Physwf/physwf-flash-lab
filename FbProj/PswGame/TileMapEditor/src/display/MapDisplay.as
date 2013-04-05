package display
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	public class MapDisplay extends Sprite
	{
		public static var mapDir:String;
		
		private var mGroundLayer:Sprite;
		private var mNpcLayer:Sprite;
		public function npcLayer():Sprite { return mNpcLayer; }
		private var mTeleprotLayer:Sprite;
		public function get teleportLayer():Sprite { return mTeleprotLayer; }
		
		
		private var mTeleports:Vector.<TeleportDisplay>;
		private var mNpcs:Vector.<NPCDisplay>;
		
		public function MapDisplay()
		{
			mGroundLayer = new Sprite();
			addChild(mGroundLayer);
			mNpcLayer = new Sprite();
			addChild(mNpcLayer);
			mTeleprotLayer = new Sprite();
			addChild(mTeleprotLayer);
			
			mTeleports = new Vector.<TeleportDisplay>();
			mNpcs = new Vector.<NPCDisplay>();
			
			addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
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
		
		public function addTeleport(tlt:TeleportDisplay):void
		{
			mTeleports.push(tlt);
			mTeleprotLayer.addChild(tlt.sceneView);
		}
		
		public function addNPC(npc:NPCDisplay):void
		{
			mNpcs.push(npc);
			mNpcLayer.addChild(npc.sceneView);
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			if(MapEditor.editor.dragItem)
			{
				MapEditor.editor.dragItem = null;
			}
		}
	}
}
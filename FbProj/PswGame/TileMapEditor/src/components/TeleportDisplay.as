package components
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TeleportDisplay extends ObjectDisplay
	{
		public static var IconDir:String;
		public static var SceneDir:String;
		
		public function TeleportDisplay(name:String)
		{
			super(name);
			iconDir = IconDir;
			sceneDir = SceneDir;
		}
		
		override protected function onMouseDown(e:MouseEvent):void
		{
			super.onMouseDown(e);
			MapEditor.editor.map.addTeleport(this);
		}
		
	}
}
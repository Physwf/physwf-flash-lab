package display
{
	import flash.display.Sprite;
	
	public class NPCDisplay extends ObjectDisplay
	{
		public static var IconDir:String;
		public static var SceneDir:String;
		
		public var id:uint;
		
		public function NPCDisplay(name:String)
		{
			super(name);
			iconDir = IconDir;
			sceneDir = SceneDir;
		}
	}
}
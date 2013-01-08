package com.physwf.components.screen
{
	import flash.display.Sprite;

	public class ScreenManager
	{
		public static var main:ScreenManager;
		
		private var mRoot:Sprite;
		
		public function ScreenManager(root:Sprite=null)
		{
			root ||= new Sprite();;
			mRoot = root; 
		}
		
		public function addLayerToTop(layer:Sprite):Sprite
		{
			if(!layer) layer = new Sprite();
			mRoot.addChild(layer);
			return layer;
		}
		
		public function addLayerToBottom(layer:Sprite):Sprite
		{
			if(!layer) layer = new Sprite();
			mRoot.addChildAt(layer,0);
			return layer;
		}
		
		public function set frameRate(v:uint):void
		{
			mRoot.stage.frameRate = v;
		}
	}
}
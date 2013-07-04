package components.screen
{
	import flash.display.Sprite;
	
	public class Layer extends Sprite
	{
		private var mRoot:Sprite;
		
		public function Layer(root:Sprite)
		{
			mRoot = root;
			mRoot.addChild(this);
		}
		
		public function addLayerToTop(layer:Sprite):Sprite
		{
			if(!layer) layer = new Sprite();
			addChild(layer);
			return layer;
		}
		
		public function addLayerToBottom(layer:Sprite):Sprite
		{
			if(!layer) layer = new Sprite();
			addChildAt(layer,0);
			return layer;
		}
	}
}
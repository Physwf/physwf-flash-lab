package components.screen
{
	import flash.display.Sprite;
	
	public class ScreenManager
	{
		public static var main:ScreenManager;
		
		private var mWorld:Layer;
		private var mFrame:Layer;
		private var mEffect:Layer;
		private var mTip:Layer;
		
		private var mRoot:Sprite;
		
		public function ScreenManager(root:Sprite=null)
		{
			root ||= new Sprite();
			mWorld = new Layer(root);
			mWorld.name = "world";
			mFrame = new Layer(root);
			mFrame.name = "frame";
			mEffect = new Layer(root);
			mEffect.name = "effect";
			mTip = new Layer(root);
			mTip.name = "tip";
			mTip.mouseEnabled = false;
			mTip.mouseChildren = false;
			mRoot = root;
		}
		
		public function get world():Layer
		{
			return mWorld;
		}
		
		public function get frame():Layer
		{
			return mFrame;
		}
		
		public function get effect():Layer
		{
			return mEffect;
		}
		
		public function get tip():Layer
		{
			return mTip;
		}
		
		public function set frameRate(v:uint):void
		{
			mRoot.stage.frameRate = v;
		}
	}
}
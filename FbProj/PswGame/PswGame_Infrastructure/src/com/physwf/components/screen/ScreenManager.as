package com.physwf.components.screen
{
	import flash.display.Sprite;

	public class ScreenManager
	{
		public static var main:ScreenManager;
		
		private var mWorld:Layer;
		private var mUi:Layer;
		private var mEffect:Layer;
		private var mTip:Layer;
		
		private var mRoot:Sprite;
		
		public function ScreenManager(root:Sprite=null)
		{
			root ||= new Sprite();
			mWorld = new Layer(root);
			mUi = new Layer(root);
			mEffect = new Layer(root);
			mWorld = new Layer(root);
			mTip = new Layer(root);
			
			mRoot = root;
		}
		
		public function get world():Layer
		{
			return mWorld;
		}
		
		public function get ui():Layer
		{
			return mUi;
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
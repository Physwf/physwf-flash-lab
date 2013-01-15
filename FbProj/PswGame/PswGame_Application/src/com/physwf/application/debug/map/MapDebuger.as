package com.physwf.application.debug.map
{
	import com.physwf.components.screen.ScreenManager;
	import com.physwf.engine.Engine;
	
	import flash.display.Sprite;

	public class MapDebuger
	{
		private var mGridLayer:GridLayer;
		private var toggleFlag:Boolean = false;
		
		public function MapDebuger()
		{
		}
		
		public function toggleAstarDebug():void
		{
			if(!mGridLayer)
			{
				mGridLayer = new GridLayer();
				mGridLayer.initialize(Engine.map.view.landform);
			}
			if(!toggleFlag)
				Engine.map.view.addChild(mGridLayer);
			else 
				mGridLayer.parent.removeChild(mGridLayer);
			toggleFlag = !toggleFlag;
		}
	}
}
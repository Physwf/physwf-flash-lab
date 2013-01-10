package com.physwf.application.debug.map
{
	import com.physwf.components.screen.ScreenManager;

	public class MapDebuger
	{
		private var mGridLayer:GridLayer;
		
		public function MapDebuger()
		{
		}
		
		public function toggleAstarDebug():void
		{
			if(!mGridLayer)
			{
				mGridLayer = new GridLayer();
			}
			mGridLayer.initialize(ScreenManager.main.world);
			ScreenManager.main.world.addLayerToTop(mGridLayer);
		}
	}
}
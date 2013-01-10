package com.physwf.application.debug.map
{
	import com.physwf.components.screen.ScreenManager;

	public class MapDebuger
	{
		private var mGridLayer:GridLayer;
		
		public function MapDebuger()
		{
		}
		
		public function enableAstarDebug():void
		{
			if(!mGridLayer)
			{
				mGridLayer = new GridLayer();
			}
			ScreenManager.main.world.addLayerToTop(mGridLayer);
		}
	}
}
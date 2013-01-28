package com.physwf.engine.bag.config
{
	import com.physwf.components.ui.config.PanelConfig;
	
	import flash.geom.Rectangle;

	public class BagAssets
	{
		public static const DIR_PANEL_ASSETS:String = "resource/ui/";
		
		public static const PANEL_BAG:PanelConfig = new PanelConfig(DIR_PANEL_ASSETS+"panels.swf",0,new Rectangle(56,40,84,176));
		
		public function BagAssets()
		{
		}
	}
}
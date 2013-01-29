package com.physwf.engine.bag.config
{
	import com.physwf.components.ui.config.CellConfig;
	import com.physwf.components.ui.config.PanelConfig;
	
	import flash.geom.Rectangle;

	public class BagAssets
	{
		public static const DIR_PANEL_ASSETS:String = "resource/ui/";
		public static const DIR_BAG_ICONS:String = "resource/icons/";
		
		public static const PANEL_BAG:PanelConfig = new PanelConfig(DIR_PANEL_ASSETS+"panels.swf",0,new Rectangle(56,40,84,176));
		public static const CELL_BAG:CellConfig = new CellConfig(DIR_PANEL_ASSETS+"cells.swf",1,3,4,4,34);
		
		public function BagAssets()
		{
		}
	}
}
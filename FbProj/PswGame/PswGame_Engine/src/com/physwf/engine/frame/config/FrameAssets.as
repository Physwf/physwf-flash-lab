package com.physwf.engine.frame.config
{
	import com.physwf.components.ui.config.BarConfig;
	import com.physwf.components.ui.config.ButtonConfig;
	import com.physwf.components.ui.config.CellConfig;

	public class FrameAssets
	{
		public static const DIR_BTN_ASSETS:String = "resource/ui/";
		
		public static const BTN_ROLE:ButtonConfig = new ButtonConfig(DIR_BTN_ASSETS+"buttons.swf",750,520,0,0,0,0);
		public static const BTN_BAG:ButtonConfig = new ButtonConfig(DIR_BTN_ASSETS+"buttons.swf",830,520,1,1,1,1);
		public static const BTN_SKILL:ButtonConfig = new ButtonConfig(DIR_BTN_ASSETS+"buttons.swf",910,520,2,2,2,2);
		public static const SKILL_BAR:BarConfig = new BarConfig(DIR_BTN_ASSETS+"skillBar.swf",[2,0]);
		public static const SKILL_CELL:CellConfig = new CellConfig(DIR_BTN_ASSETS+"cells.swf",1,3,4,4,34);
		
		public function FrameAssets()
		{
		}
	}
}
package com.physwf.engine.frame.config
{
	import com.physwf.components.ui.config.BarConfig;
	import com.physwf.components.ui.config.ButtonConfig;
	import com.physwf.components.ui.config.CellConfig;

	public class FrameAssets
	{
		public static const DIR_ASSETS:String = "resource/ui/";
		
		public static const BTN_ROLE:ButtonConfig = new ButtonConfig(DIR_ASSETS+"buttons.swf",750,520,0,0,0,0);
		public static const BTN_BAG:ButtonConfig = new ButtonConfig(DIR_ASSETS+"buttons.swf",830,520,1,1,1,1);
		public static const BTN_SKILL:ButtonConfig = new ButtonConfig(DIR_ASSETS+"buttons.swf",910,520,2,2,2,2);
		public static const SKILL_BAR:BarConfig = new BarConfig(DIR_ASSETS+"skillBar.swf",[2,0]);
		public static const SKILL_CELL:CellConfig = new CellConfig(DIR_ASSETS+"cells.swf",1,3,3,3,34);
		
		public static const CURSOR_AIM_NAME:String = "aim";
		public static const CURSOR_AIM_ASSETS:Array = [0];
		
		public function FrameAssets()
		{
		}
	}
}
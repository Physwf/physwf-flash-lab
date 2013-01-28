package com.physwf.engine.frame.config
{
	import com.physwf.components.ui.config.ButtonConfig;

	public class AssetsConfig
	{
		public static const DIR_BTN_ASSETS:String = "resource/ui/";
		
		public static const BTN_ROLE:ButtonConfig = new ButtonConfig(DIR_BTN_ASSETS+"buttons.swf",750,520,0,0,0,0);
		public static const BTN_BAG:ButtonConfig = new ButtonConfig(DIR_BTN_ASSETS+"buttons.swf",830,520,1,1,1,1);
		public static const BTN_SKILL:ButtonConfig = new ButtonConfig(DIR_BTN_ASSETS+"buttons.swf",910,520,2,2,2,2);
		
		public function AssetsConfig()
		{
		}
	}
}
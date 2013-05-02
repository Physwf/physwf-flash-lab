package com.physwf.components.ui.layout
{
	import com.physwf.components.ui.controls.Button;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import com.physwf.components.ui.assets.WindowAssets;
	
	public class Window extends Panel
	{
		private var btnClose:Button;
		
		public function Window(assets:WindowAssets)
		{
			btnClose = assets.btnClose;
			super(assets.bgAssets);
		}
	}
}
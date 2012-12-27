package com.physwf.components.map.layer.tile
{
	import flash.display.BitmapData;
	
	public class StaticBmdTile extends BitmapDataTile
	{
		public function StaticBmdTile(bmd:BitmapData)
		{
			super(bmd);
		}
		
		override public function install():void
		{
			if(installed) return;
			_viewData = AssetsFactory.getBitmapData();
			canvas.copyPixels(_viewData,_viewData.rect,rect.topLeft,null,null,true);
			installed = true;
		}
		
		override public function uninstall():void
		{
			
		}
	}
}
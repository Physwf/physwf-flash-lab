package com.physwf.components.ui.assets
{
	import com.physwf.components.interfaces.IDisposible;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class PanelAssets implements IDisposible
	{
		public var asset:BitmapData;
		public var scale9Grid:Rectangle;
		
		public function PanelAssets()
		{
		}
		
		public function destroy():void
		{
		}
	}
}
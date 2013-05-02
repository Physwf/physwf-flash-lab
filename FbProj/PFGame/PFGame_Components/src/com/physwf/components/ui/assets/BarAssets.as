package com.physwf.components.ui.assets
{
	import flash.display.BitmapData;

	public class BarAssets
	{
		public var parts:Vector.<BitmapData>;
		public var isAssetsDirty:Boolean = false;
		
		public function BarAssets()
		{
			parts = new Vector.<BitmapData>();
		}
	}
}
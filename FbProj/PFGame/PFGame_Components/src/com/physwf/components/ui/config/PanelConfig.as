package com.physwf.components.ui.config
{
	import flash.geom.Rectangle;

	public class PanelConfig
	{
		public var url:String;
		public var assetsID:uint;
		public var scale9Grid:Rectangle;
		
		public function PanelConfig(url:String,id:uint,s9g:Rectangle)
		{
			this.url = url;
			assetsID = id;
			scale9Grid = s9g;
		}
	}
}
package com.physwf.components.ui.config
{
	public class BarConfig
	{
		public var url:String;
		public var assets:Vector.<uint>;
		
		public function BarConfig($url:String,$assets:Array)
		{
			url = $url;
			assets = Vector.<uint>($assets);
		}
	}
}
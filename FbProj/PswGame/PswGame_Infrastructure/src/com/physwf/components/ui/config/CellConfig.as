package com.physwf.components.ui.config
{
	public class CellConfig
	{
		public var url:String;
		public var bg:uint;
		public var over:uint;
		public var up:uint;
		public var down:uint;
		
		public function CellConfig($url:String,$bg:uint,$over:uint,$up:uint,$down:uint)
		{
			url = $url;
			bg = $bg;
			over = $over;
			up = $up;
			down = $down;
		}
	}
}
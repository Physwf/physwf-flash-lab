package com.physwf.components.ui.config
{
	public class ButtonConfig
	{
		public var url:String;
		public var up:uint;
		public var over:uint;
		public var down:uint;
		public var hit:uint;
		public var x:uint;
		public var y:uint;
		
		public function ButtonConfig(url:String,x:uint,y:uint,up:uint,over:uint,down:uint,hit:uint)
		{
			this.url = url;
			this.x = x;
			this.y = y;
			this.up = up;
			this.over = over;
			this.down = down;
			this.hit = hit;
		}
	}
}
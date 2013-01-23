package com.physwf.components.ui.layout
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import com.physwf.components.ui.assets.PanelAssets;
	
	public class Panel extends Sprite
	{
		private var leftTop:Bitmap;
		private var top:Bitmap;
		private var rightTop:Bitmap;
		private var right:Bitmap;
		private var rightDown:Bitmap;
		private var down:Bitmap;
		private var leftDown:Bitmap;
		private var left:Bitmap;
		
		private var midle:Bitmap;
		
		public function Panel(assets:PanelAssets)
		{
			leftTop = new Bitmap(assets.leftTop);
			top = new Bitmap(assets.top);
			rightTop = new Bitmap(assets.rightTop);
			right = new Bitmap(assets.right);
			rightDown = new Bitmap(assets.rightDown);
			down = new Bitmap(assets.down);
			leftDown = new Bitmap(assets.leftDown);
			left = new Bitmap(assets.left);
			
			midle = new Bitmap(assets.midle);
			
			top.x = leftTop.width;
			rightTop.x = top.x + top.width;
			right.x = rightTop.x;
			right.y = rightTop.y + rightTop.height;
			rightDown.x = right.x;
			rightDown.y = right.y + right.height;
			down.y = rightDown.y;
			down.x = rightDown.x - down.width;
			leftDown.x = down.x - leftDown.width;
			leftDown.y = down.y;
			left.x = leftDown.x;
			left.y = leftDown.y - left.height;
			leftTop.x = left.x;
			leftTop.y = left.y - leftTop.height;
		}
	}
}
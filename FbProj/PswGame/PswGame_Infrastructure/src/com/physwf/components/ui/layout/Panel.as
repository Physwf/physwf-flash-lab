package com.physwf.components.ui.layout
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.assets.PanelAssets;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Panel extends Sprite implements IPopup,IUpdatable
	{
		private var mLeftTop:Bitmap;
		private var mTop:Bitmap;
		private var mRightTop:Bitmap;
		private var mRight:Bitmap;
		private var mRightDown:Bitmap;
		private var mDown:Bitmap;
		private var mLeftDown:Bitmap;
		private var mLeft:Bitmap;
		private var mMiddle:Bitmap;
		
		private var assets:PanelAssets;
		private var scale9:Rectangle;
		
		private var isShow:Boolean = false;
		
		public function Panel(assets:PanelAssets)
		{
			this.assets = assets;
			
			mLeftTop = new Bitmap();
			mTop = new Bitmap();
			mRightTop = new Bitmap();
			mRight = new Bitmap();
			mRightDown = new Bitmap();
			mDown = new Bitmap();
			mLeftDown = new Bitmap();
			mLeft = new Bitmap();
			mMiddle = new Bitmap();
			
			addChild(mLeftTop);
			addChild(mTop);
			addChild(mRightTop);
			addChild(mRight);
			addChild(mRightDown);
			addChild(mDown);
			addChild(mLeftDown);
			addChild(mLeft);
			addChild(mMiddle);
		}
		
		public function toggle($parent:DisplayObjectContainer):void
		{
			isShow = !isShow;
			if(isShow) 
			{
				show($parent);
			}
			else
			{
				hide();
			}
		}
		
		public function hide():void
		{
			parent && parent.removeChild(this);
		}
		
		public function show($parent:DisplayObjectContainer):void
		{
			$parent.addChild(this);
		}
		
		public function update():void
		{
			if(scale9 != assets.scale9Grid)
			{
				scale9 = assets.scale9Grid;
				setScale();
			}
		}
		
		private function setScale():void
		{
			var s9g:Rectangle = assets.scale9Grid;
			
			var topH:Number = s9g.y;
			var leftW:Number = s9g.x;
			var bottomH:Number = assets.asset.height - s9g.bottom;
			var rightW:Number = assets.asset.width - s9g.right;
			
			var topLeft:Rectangle = new Rectangle(0,0,leftW,topH);
			var top:Rectangle = new Rectangle(leftW,0,s9g.width,topH);
			var rightTop:Rectangle = new Rectangle(top.right,top.y,rightW,topH);
			var right:Rectangle = new Rectangle(s9g.right,s9g.top,rightW,s9g.height);
			var rightDown:Rectangle = new Rectangle(s9g.bottomRight.x,s9g.bottomRight.y,rightW,bottomH);
			var down:Rectangle = new Rectangle(s9g.left,s9g.bottom,s9g.width,bottomH);
			var leftDown:Rectangle = new Rectangle(0,s9g.bottom,leftW,bottomH);
			var left:Rectangle = new Rectangle(0,topH,leftW,s9g.height);
			
			var bmd:BitmapData = new BitmapData(topLeft.width,topLeft.height,true,0);
			bmd.copyPixels(assets.asset,topLeft,new Point());
			mLeftTop.bitmapData = bmd;
			
			bmd = new BitmapData(top.width,top.height,true,0);
			bmd.copyPixels(assets.asset,top,new Point());
			mTop.bitmapData = bmd;
			
			bmd = new BitmapData(rightTop.width,rightTop.height,true,0);
			bmd.copyPixels(assets.asset,rightTop,new Point());
			mRightTop.bitmapData = bmd;
			
			bmd = new BitmapData(right.width,right.height,true,0);
			bmd.copyPixels(assets.asset,right,new Point());
			mRight.bitmapData = bmd;
			
			bmd = new BitmapData(rightDown.width,rightDown.height,true,0);
			bmd.copyPixels(assets.asset,rightDown,new Point());
			mRightDown.bitmapData = bmd;
			
			bmd = new BitmapData(down.width,down.height,true,0);
			bmd.copyPixels(assets.asset,down,new Point());
			mDown.bitmapData = bmd;
			
			bmd = new BitmapData(leftDown.width,leftDown.height,true,0);
			bmd.copyPixels(assets.asset,leftDown,new Point());
			mLeftDown.bitmapData = bmd;
			
			bmd = new BitmapData(left.width,left.height,true,0);
			bmd.copyPixels(assets.asset,left,new Point());
			mLeft.bitmapData = bmd;
		}
	}
}
package com.physwf.components.ui
{
	import com.physwf.components.interfaces.IUpdatable;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;

	public class DragManager implements IUpdatable
	{
		public static var instance:DragManager;
		
		private var mLayer:Sprite;
		
		private var mDragItem:Bitmap;
		public var dragInfo:*;//拖拽对象的信息
		
		private var mOffsetX:uint;
		private var mOffsetY:uint;
		
		public function DragManager(layer:Sprite)
		{
			if(instance) throw "Singleton!!!";
			mLayer = layer;
		}
		
		public function set dragItem(v:BitmapData):void 
		{ 
			mDragItem && mDragItem.parent && mDragItem.parent.removeChild(mDragItem);
			if(v) 
			{
				mDragItem = new Bitmap(v);
				mDragItem.alpha = .5;
				mLayer.addChild(mDragItem);
				mOffsetX = v.width * .5;
				mOffsetY = v.height * .5;
			}
			else
			{
				mDragItem = null;
			}
		}
		
		public function get dragItem():BitmapData
		{
			return mDragItem?mDragItem.bitmapData:null;
		}
		
		public function update():void
		{
			if(mDragItem)
			{
				mDragItem.x = mLayer.mouseX - mOffsetX;
				mDragItem.y = mLayer.mouseY - mOffsetY;
			}
		}
	}
}
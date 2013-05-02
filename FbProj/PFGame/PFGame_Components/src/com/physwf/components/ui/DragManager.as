package com.physwf.components.ui
{
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.controls.Cell;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.filters.ColorMatrixFilter;

	public class DragManager implements IUpdatable
	{
		public static var instance:DragManager;
		
		private var mLayer:Sprite;
		
		private var mDragItem:Bitmap;
		public var dragInfo:*;//拖拽对象的信息
		
		private var mCellDraged:Cell;
		
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
				update();
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
		
		public function set cellDraged(v:Cell):void
		{
			if(v)
			{
				mCellDraged = v;
				mCellDraged.content.filters = [
					new ColorMatrixFilter(
					[
						0.3086, 0.6094, 0.0820, 0, 0,  
						0.3086, 0.6094, 0.0820, 0, 0,  
						0.3086, 0.6094, 0.0820, 0, 0,  
						0,      0,      0,      1, 0
					])];
			}
			else
			{
				if(mCellDraged)
				{
					mCellDraged.content.filters = null;
					mCellDraged.contentData = null;
					mCellDraged = null;
				}
			}
		}
		
		public function get cellDraged():Cell
		{
			return mCellDraged;
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
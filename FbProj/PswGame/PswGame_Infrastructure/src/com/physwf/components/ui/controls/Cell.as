package com.physwf.components.ui.controls
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.assets.CellAssets;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Cell extends Sprite implements IUpdatable,IDisposible
	{
		public static const STATE_UP:uint = 0;
		public static const STATE_OVER:uint = 1;
		public static const STATE_DOWN:uint = 2;
		
		public var data:*;//格子所对应的数据
		
		private var bg:Bitmap;
		private var content:Bitmap;
		private var state:Bitmap;
		
		private var assets:CellAssets;
		
		private var mState:uint = STATE_UP;
		
		public function Cell(assets:CellAssets)
		{
			this.assets = assets;
			
			bg = new Bitmap();
			addChild(bg);
			
			content = new Bitmap();
			addChild(content);
			
			state = new Bitmap();
			addChild(state);
			configListeners();
		}
		
		private function configListeners():void
		{
			addEventListener(MouseEvent.MOUSE_OVER,onMouseEvent,false,Number.POSITIVE_INFINITY,false);
			addEventListener(MouseEvent.MOUSE_OUT,onMouseEvent,false,Number.POSITIVE_INFINITY,false);
			
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseEvent,false,Number.POSITIVE_INFINITY,false);
			addEventListener(MouseEvent.MOUSE_UP,onMouseEvent,false,Number.POSITIVE_INFINITY,false);
		}
		
		private function onMouseEvent(e:MouseEvent):void
		{
			switch(e.type)
			{
				case MouseEvent.MOUSE_OVER:
					mState = STATE_OVER;
					break;
				case MouseEvent.MOUSE_OUT:
					mState = STATE_UP;
					break;
				case MouseEvent.MOUSE_DOWN:
					mState = STATE_DOWN;
					break;
				case MouseEvent.MOUSE_UP:
					mState = STATE_OVER;
					break;
			}
		}
		
		public function set contentData(data:BitmapData):void
		{
			if(content.bitmapData)
			{
				content.bitmapData.dispose();
			}
			content.bitmapData = data;
			content.width = content.height = assets.size;
		}
		
		public function get contentData():BitmapData
		{
			return content.bitmapData;
		}
		
		public function update():void
		{
			if(bg.bitmapData != assets.bg)
			{
				bg.bitmapData = assets.bg;
			}
			switch(mState)
			{
				case STATE_UP:
					if(state.bitmapData != assets.upstate)
					{
						state.bitmapData = assets.upstate;
					}
					break;
				case STATE_OVER:
					if(state.bitmapData != assets.overstate)
					{
						state.bitmapData = assets.overstate;
					}
					break;
				case STATE_DOWN:
					if(state.bitmapData != assets.downstate)
					{
						state.bitmapData = assets.downstate;
					}
					break;
			}
		}
		
		public function destroy():void
		{
			
		}
	}
}
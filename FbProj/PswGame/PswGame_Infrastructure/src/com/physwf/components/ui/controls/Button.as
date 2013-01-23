package com.physwf.components.ui.controls
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.ui.assets.ButtonAssets;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Button extends Sprite implements IDisposible
	{
		private var mAssets:ButtonAssets;
		
		private var mDisplay:Bitmap;
		
		public function Button(assets:ButtonAssets)
		{
			mAssets = assets;
			mDisplay = new Bitmap(mAssets.upState);
			addChild(mDisplay);
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
					break;
				case MouseEvent.MOUSE_OUT:
					break;
				case MouseEvent.MOUSE_DOWN:
					break;
				case MouseEvent.MOUSE_UP:
					break;
			}
		}
		
		public function destroy():void
		{
			mAssets.destroy();		
			mAssets = null;
			mDisplay = null;
		}
	}
}
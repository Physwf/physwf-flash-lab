package com.physwf.components.ui.controls
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.assets.ButtonAssets;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Button extends Sprite implements IDisposible,IUpdatable
	{
		public static const STATE_UP:uint = 0;
		public static const STATE_OVER:uint = 1;
		public static const STATE_DOWN:uint = 2;
		public static const STATE_HIT:uint = 3;
		
		private var mAssets:ButtonAssets;
		
		private var mDisplay:Bitmap;
		private var mState:uint;
		
		public function Button(assets:ButtonAssets)
		{
			buttonMode = true;
			mAssets = assets;
			mState = STATE_UP;
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
		
		public function update():void
		{
			switch(mState)
			{
				case STATE_UP:
					if(mDisplay.bitmapData != mAssets.upState)
					{
						mDisplay.bitmapData = mAssets.upState;
					}
					break;
				case STATE_OVER:
					if(mDisplay.bitmapData != mAssets.overState)
					{
						mDisplay.bitmapData = mAssets.overState;
					}
					break;
				case STATE_DOWN:
					if(mDisplay.bitmapData != mAssets.downState)
					{
						mDisplay.bitmapData = mAssets.downState;
					}
					break;
				case STATE_HIT:
					if(mDisplay.bitmapData != mAssets.hitState)
					{
						mDisplay.bitmapData = mAssets.hitState;
					}
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
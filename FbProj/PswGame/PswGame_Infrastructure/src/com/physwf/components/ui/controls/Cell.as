package com.physwf.components.ui.controls
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.assets.CellAssets;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class Cell extends Sprite implements IUpdatable,IDisposible
	{
		public static const STATE_UP:uint = 0;
		public static const STATE_OVER:uint = 1;
		public static const STATE_DOWN:uint = 2;
		
		private var bg:Bitmap;
		private var  content:Bitmap;
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
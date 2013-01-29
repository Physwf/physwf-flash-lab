package com.physwf.components.ui.layout
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.IUpdatable;
	import com.physwf.components.ui.assets.BarAssets;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class HBar extends Sprite implements IUpdatable, IDisposible
	{
		private var assets:BarAssets;
		private var mDispaly:Bitmap;
		
		public function HBar($assets:BarAssets)
		{
			assets = $assets;
			mDispaly = new Bitmap();
			addChild(mDispaly);
		}
		
		public function update():void
		{
			if(assets.isAssetsDirty)
			{
				assets.isAssetsDirty = false;
				var tempSp:Sprite = new Sprite();
				var offset:Number = 0;
				var bottom:Number = assets.parts[0].height;
				for(var i:int=0;i<assets.parts.length;++i)
				{
					var part:Bitmap = new Bitmap(assets.parts[i]);
					part.x = offset;
					part.y = bottom - part.height;
					offset += part.width;
					tempSp.addChild(part);
				}
				var bmd:BitmapData = new BitmapData(tempSp.width,tempSp.height,true,0);
				bmd.draw(tempSp);
				mDispaly.bitmapData = bmd;
			}
			
		}
		
		public function destroy():void
		{
			
		}
	}
}
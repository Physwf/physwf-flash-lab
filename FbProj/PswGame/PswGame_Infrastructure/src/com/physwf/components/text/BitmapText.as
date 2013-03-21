package com.physwf.components.text
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class BitmapText extends Bitmap
	{
		private var mStyle:String;
		
		public function BitmapText(style:String)
		{
			mStyle = style;
			super(null, "auto", false);
		}
		
		public function set text(v:String):void
		{
			bitmapData && bitmapData.dispose();
			
			var loader:BitmapTextLoader = BitmapTextLoader.getSameBTLoader(mStyle);
			var num:uint = 0;
			function onComplete(e:Event):void
			{
				loader.removeEventListener(Event.COMPLETE,onComplete);
				while(v.length)
				{
					var unicode:uint = v.charCodeAt(0);
					var bmd:BitmapData = loader.getText(unicode);
					if(bitmapData == null)
					{
						bitmapData = new BitmapData(bmd.width*v.length,bmd.height,true,0);//只第一次有效
					}
					bitmapData.copyPixels(bmd,bmd.rect,new Point(num*bmd.width,0));
					num++;
					trace(v);
					v = v.substring(1,v.length);
					
				}
			}
			loader.addEventListener(Event.COMPLETE,onComplete);
			loader.load();
		}
		
		public function get text():String
		{
			return null;
		}
	}
}
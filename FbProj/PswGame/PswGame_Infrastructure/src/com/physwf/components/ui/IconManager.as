package com.physwf.components.ui
{
	import com.physwf.components.ui.controls.Cell;
	import com.physwf.components.utils.BMPDecoder;
	import com.physwf.components.utils.IDecoder;
	import com.physwf.components.utils.TGADecoder;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class IconManager
	{
		public static var iconDir:String;
		
		private static var iconList:Dictionary = new Dictionary();
		
		public function IconManager()
		{
		}
		
		public static function setCell(cell:Cell,iconId:uint,format:String=".jpg"):void
		{
			if(!iconList[iconId])
			{
				iconList[iconId] = cell.content;
				load(cell,iconId,format);
			}
			else
			{
				cell.contentData = Bitmap(iconList[iconId]).bitmapData;
			}
		}
		
		private static function load(cell:Cell,id:uint,format:String):void
		{
			switch(format)
			{
				case ".jpg":
				case ".png":
					var loader:Loader = new Loader();
					function onLoaderComplete(e:Event):void
					{
						loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoaderComplete);
						cell.contentData = Bitmap(loader.content).bitmapData;
					};
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete);
					loader.load(new URLRequest(iconDir+id+format));
					break;
				case ".bmp":
					var decoder:IDecoder = new BMPDecoder();
					select(decoder,cell,iconDir+id+format);
					break;
				case ".tga":
					decoder = new TGADecoder();
					select(decoder,cell,iconDir+id+format);
					break;
			}
		}
		
		private static function select(decoder:IDecoder,cell:Cell,url:String):void
		{
			var stream:URLStream = new URLStream();
			function onStreamComplete(e:Event):void
			{
				stream.removeEventListener(Event.COMPLETE,onStreamComplete);
				var imageData:ByteArray = new ByteArray();
				stream.readBytes(imageData,0,stream.bytesAvailable);
				cell.contentData = decoder.decode(imageData);
			};
			stream.addEventListener(Event.COMPLETE,onStreamComplete);
			stream.load(new URLRequest(url));
		}
	}
}
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
	/**
	 * 这个类提供了icon缓存机制 ,iconList中存有Bitmap对象，但这些对象并不被任何cell实例引用，这些实例只是为了缓存icon的位图数据。
	 * 每个cell实例只引用这些bitmap的位图数据。
	 * @author joe
	 * 
	 */
	public class IconLoader
	{
		public static var iconDir:String;
		private static var iLoaders:Dictionary = new Dictionary();
		private static var iconList:Dictionary = new Dictionary();
		private var mName:String;
		
		public function IconLoader(name:String)
		{
			mName = name;
		}
		
		public static function getSameIconLoader(name:String):IconLoader
		{
			var iLoader:IconLoader = iLoaders[name] as IconLoader;
			if(iLoader) return iLoader;
			iLoader = new IconLoader(name);
			iLoaders[name] = iLoader;
			return iLoader;
		}
		
		public function setCell(cell:Cell,iconId:uint,format:String=".jpg"):void
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
		
		private function load(cell:Cell,id:uint,format:String):void
		{
			var url:String = iconDir+mName+"/"+id+format;
			switch(format)
			{
				case ".jpg":
				case ".png":
					var loader:Loader = new Loader();
					var onLoaderComplete:Function = function (e:Event):void
					{
						loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoaderComplete);
						cell.contentData = Bitmap(loader.content).bitmapData;
					};
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete);
					loader.load(new URLRequest(url));
					break;
				case ".bmp":
					var decoder:IDecoder = new BMPDecoder();
					select(decoder,cell,url);
					break;
				case ".tga":
					decoder = new TGADecoder();
					select(decoder,cell,url);
					break;
			}
		}
		
		private function select(decoder:IDecoder,cell:Cell,url:String):void
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
		/**
		 * 清空缓存，在游戏中可以选择执行，比如在切换场景时，或者根据一定启发算法来调用 。
		 * 
		 */		
		public static function clear():void
		{
			for each(var item:Bitmap in iconList)
			{
				item.bitmapData && item.bitmapData.dispose();
			}
			iconList = new Dictionary();
		}
	}
}
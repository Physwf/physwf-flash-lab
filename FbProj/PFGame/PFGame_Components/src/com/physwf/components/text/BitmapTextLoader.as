package com.physwf.components.text
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * 位图文本加载器
	 * 位图文本的文件格式为  位图宽度+位图高度+[uinicode(16)+位图数据] 
	 * @author joe
	 * 
	 */	
	public class BitmapTextLoader extends EventDispatcher
	{
		public static const LOAD_FLAG_NO:uint = 0;
		public static const LOAD_FLAG_LOADING:uint = 1;
		public static const LOAD_FLAG_YES:uint = 3;
		
		private static var btLoaders:Dictionary = new Dictionary();
		private var mUrl:String;
		private var mPostfix:String;
		
		private var mLoadFlag:uint = 0;
		public function get hasLoaded():Boolean { return mLoadFlag == LOAD_FLAG_YES; }
		
		private var mTextData:Dictionary;
		
		public function BitmapTextLoader(url:String,postfix:String=".swf")
		{
			mUrl = url;
			mPostfix = postfix;
		}
		
		public static function getSameBTLoader(url:String,postfix:String=".swf"):BitmapTextLoader
		{
			if(btLoaders[url])
			{
				return btLoaders[url] as BitmapTextLoader;
			}
			var eLoader:BitmapTextLoader = new BitmapTextLoader(url,postfix);
			btLoaders[url] = eLoader;
			return eLoader;
		}
		
		public function load():void
		{
			//判断加载状态
			if(mLoadFlag == LOAD_FLAG_YES)
			{
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			else if(mLoadFlag == LOAD_FLAG_LOADING)
			{
				return;
			}
			else
			{
				mLoadFlag = LOAD_FLAG_LOADING;
			}
			var stream:URLStream = new URLStream();
			stream.addEventListener(Event.COMPLETE,onComplete);
			stream.load(new URLRequest(mUrl+mPostfix));
		}
		
		private function onComplete(e:Event):void
		{
			var stream:URLStream = e.target as URLStream;
			stream.removeEventListener(Event.COMPLETE,onComplete);
			var fileData:ByteArray = new ByteArray();
			stream.readBytes(fileData);
			fileData.inflate();
			
			var w:uint = fileData.readUnsignedInt();
			var h:uint = fileData.readUnsignedInt();
			var len:uint = w * h * 4;//位图单元的字节数
			
			mTextData = new Dictionary();
			
			while(fileData.bytesAvailable)
			{
				var unicode:uint = fileData.readUnsignedShort();
				var textData:ByteArray = new ByteArray();
				fileData.readBytes(textData,0,len);
				var bmd:BitmapData = new BitmapData(w,h,true,0);
				bmd.setPixels(bmd.rect,textData);
				mTextData[unicode] = bmd;
			}
			mLoadFlag = LOAD_FLAG_YES;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function getText(unicode:uint):BitmapData
		{
			return mTextData[unicode] as BitmapData;
		}
	}
}
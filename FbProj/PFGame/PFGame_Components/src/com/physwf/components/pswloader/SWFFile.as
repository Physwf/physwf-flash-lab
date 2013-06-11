package com.physwf.components.pswloader
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	/**
	 * swf项目
	 * 为了防止安全沙箱错误，先用stream加载，在用loader进行解析。 但未对该方法进行效率上的测试。
	 * @author Physwf
	 * 
	 */
	public class SWFFile extends File
	{
		public var domain:ApplicationDomain;//为该swf指定的应用程序域
		
		private var mStream:URLStream;
		
		public function SWFFile(url:String,uid:String)
		{
			super(url,uid);
		}
		
		override public function load():void
		{
			mStream = new URLStream();
			mStream.addEventListener(Event.COMPLETE,onComplete);
			mStream.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			mStream.load(new URLRequest(mUrl));
			super.load();
		}
		
		override public function stop():void
		{
			if(mLoadStatus == LOAD_STATUS_LOADING)
			{
				mStream.removeEventListener(Event.COMPLETE,onComplete);
				mStream.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
				mStream.close();
			}
			super.stop();
		}
		
		private function onComplete(e:Event):void
		{
			mLoadStatus = LOAD_STATUS_LOADED;
			var swfData:ByteArray = new ByteArray();
			mStream.removeEventListener(Event.COMPLETE,onComplete);
			mStream.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
			mStream.readBytes(swfData);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onSwfComplete);
			loader.loadBytes(swfData,new LoaderContext(false,domain));
		}
		
		private function onSwfComplete(e:Event):void
		{
			var target:LoaderInfo = e.target as LoaderInfo;
			target.removeEventListener(Event.COMPLETE,onSwfComplete);
			mContent = target.loader.content;
			target.loader.unloadAndStop();
		}
	}
}
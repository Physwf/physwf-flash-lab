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
	public class SWFItem extends LoadingItem
	{
		public var domain:ApplicationDomain;//为该swf指定的应用程序域
		
		public function SWFItem(url:String,uid:String)
		{
			super(url,uid);
		}
		
		override public function load():void
		{
			var stream:URLStream = new URLStream();
			stream.addEventListener(Event.COMPLETE,onComplete);
			stream.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			stream.load(new URLRequest(mUrl));
		}
		
		private function onComplete(e:Event):void
		{
			var swfData:ByteArray = new ByteArray();
			var stream:URLStream = e.target as URLStream;
			stream.removeEventListener(Event.COMPLETE,onComplete);
			stream.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
			stream.readBytes(swfData);
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
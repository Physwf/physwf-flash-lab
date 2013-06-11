package com.physwf.components.pswloader
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;

	public class BinaryFile extends File
	{
		private var mStream:URLStream;
		
		public function BinaryFile(url:String,uid:String,...args)
		{
			super(url,uid);
		}
		
		override public function load():void
		{
			mStream = new URLStream();
			mStream.addEventListener(Event.COMPLETE,onComplete,false);
			mStream.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			mStream.load(new URLRequest(url));
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
			var content:ByteArray = new ByteArray();
			mStream.removeEventListener(Event.COMPLETE,onComplete,false);
			mStream.readBytes(content);
			mContent = content;
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
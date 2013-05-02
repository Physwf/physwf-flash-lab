package com.physwf.components.pswloader
{
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;

	public class BinaryItem extends LoadingItem
	{
		public function BinaryItem(url:String,uid:String,...args)
		{
			super(url,uid);
		}
		
		override public function load():void
		{
			var stream:URLStream = new URLStream();
			stream.addEventListener(Event.COMPLETE,onComplete,false);
			stream.load(new URLRequest(url));
		}
		
		private function onComplete(e:Event):void
		{
			var content:ByteArray = new ByteArray();
			var stream:URLStream = e.target as URLStream;
			stream.removeEventListener(Event.COMPLETE,onComplete,false);
			stream.readBytes(content);
			mContent = content;
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
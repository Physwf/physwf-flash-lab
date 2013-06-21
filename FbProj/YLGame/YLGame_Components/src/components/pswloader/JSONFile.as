package components.pswloader
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;

	public class JSONFile extends File
	{
		private var mStream:URLStream;
		
		public function JSONFile(url:String, uid:String)
		{
			super(url, uid);
		}
		
		override public function load():void
		{
			mStream = new URLStream();
			mStream.addEventListener(Event.COMPLETE,onComplete);
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
			var content:String = mStream.readUTFBytes(mStream.bytesAvailable);
			mContent = JSON.parse(content);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		override public function destroy():void
		{
			mStream = null;
			super.destroy();
		}
	}
}
package components.pswloader
{
	import components.interfaces.IDisposible;
	import components.interfaces.INumerical;
	
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	
	public class File extends EventDispatcher implements INumerical,IDisposible
	{
		public static const LOAD_STATUS_LOADING:uint = 1;
		public static const LOAD_STATUS_LOADED:uint = 2;
		
		public var priority:Number;
		public var isDistroyed:Boolean;
		
		protected var mUrl:String;
		protected var mUID:String;
		
		protected var mContent:*;
		
		protected var mLoadStatus:uint;
		
		public function File(url:String,uid:String)
		{
			mUrl = url;
			mUID = uid;
		}
		
		public function load():void
		{
			mLoadStatus = LOAD_STATUS_LOADING;
		}
		
		protected function onIOError(e:IOErrorEvent):void
		{
			mLoadStatus = 0;
			trace(this,"Bad url!!!",mUrl);
		}
		
		public function getContent(clearMemery:Boolean=true):*
		{
			return mContent;
		}
		
		public function get url():String
		{
			return mUrl;
		}
		
		public function get uid():String
		{
			return mUID;
		}
		
		public function get isLoaded():Boolean { return mLoadStatus == LOAD_STATUS_LOADED; }
		public function get isLoading():Boolean { return mLoadStatus == LOAD_STATUS_LOADING; }
		
		public function get value():Number
		{
			return priority;
		}
		
		public function stop():void
		{
			mLoadStatus = 0;
		}
		
		public function destroy():void
		{
			isDistroyed = true;
			mUrl = null;
			mContent = null;
		}
	}
}
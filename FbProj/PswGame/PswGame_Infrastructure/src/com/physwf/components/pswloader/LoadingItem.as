package com.physwf.components.pswloader
{
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.INumerical;
	
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLStream;

	public class LoadingItem extends EventDispatcher implements INumerical,IDisposible
	{
		public static const LOAD_STATUS_LOADING:uint = 1;
		public static const LOAD_STATUS_LOADED:uint = 2;
		
		public var priority:Number;
		
		protected var mUrl:String;
		protected var mUID:String;
		
		protected var mContent:*;
		
		protected var mLoadStatus:uint;
		
		public function LoadingItem(url:String,uid:String)
		{
			mUrl = url;
			mUID = uid;
		}
		
		public function load():void
		{
			
		}
		
		protected function onIOError(e:IOErrorEvent):void
		{
			trace(this,"Bad url!!!",mUrl);
		}
		
		public function getContent():*
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
		
		public function destroy():void
		{
			mUrl = null;
			mContent = null;
		}
	}
}
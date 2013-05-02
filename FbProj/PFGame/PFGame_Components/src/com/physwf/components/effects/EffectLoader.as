package com.physwf.components.effects
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class EffectLoader extends EventDispatcher
	{
		public static const LOAD_FLAG_NO:uint = 0;
		public static const LOAD_FLAG_LOADING:uint = 1;
		public static const LOAD_FLAG_YES:uint = 3;
		
		private static var eLoaders:Dictionary = new Dictionary();
		private var mUrl:String;
		private var mPostfix:String;
		
		private var mLoadFlag:uint = 0;
		public function get hasLoaded():Boolean { return mLoadFlag == LOAD_FLAG_YES; }
		
		private var mFrames:Vector.<EffectFrame>;
		
		public function EffectLoader(url:String,postfix:String=".swf")
		{
			mUrl = url;
			mPostfix = postfix;
		}
		/**
		 * 工厂方法,应该通过该方法来构造实例，而不是通过构造函数。
		 * @return 
		 * 
		 */		
		public static function getSameEffectLoader(url:String,postfix:String=".swf"):EffectLoader
		{
			if(eLoaders[url])
			{
				return eLoaders[url] as EffectLoader;
			}
			var eLoader:EffectLoader = new EffectLoader(url);
			eLoaders[url] = eLoader;
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
			var num:uint = stream.readUnsignedByte();
			var frame:EffectFrame;
			mFrames = new Vector.<EffectFrame>(num,true);
			
			for(var i:uint=0;i<num;++i)
			{
				frame = new EffectFrame();
				frame.x = stream.readShort();
				frame.y = stream.readShort();
				var w:uint = stream.readUnsignedShort();
				var h:uint = stream.readUnsignedShort();
				var len:uint = stream.readUnsignedInt();
				var data:ByteArray = new ByteArray();
				stream.readBytes(data,0,len);
				data.inflate();
				var bmd:BitmapData = new BitmapData(w,h,true,0);
				bmd.setPixels(new Rectangle(0,0,w,h),data);
				frame.frameData = bmd;
				mFrames[i] = frame;
			}
			mLoadFlag = LOAD_FLAG_YES;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function getFrames():Vector.<EffectFrame>
		{
			return mFrames;
		}
	}
}
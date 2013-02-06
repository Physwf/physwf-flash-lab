package com.physwf.components.effects
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
	 * 暗黑特效加载器 
	 * @author joe
	 * 
	 */	
	public class DiabloEffectLoader extends EventDispatcher
	{
		public static const LOAD_FLAG_NO:uint = 0;
		public static const LOAD_FLAG_LOADING:uint = 1;
		public static const LOAD_FLAG_YES:uint = 3;
		
		private static var dLoaders:Dictionary = new Dictionary();
		private var mUrl:String;
		private var mPostfix:String;
		
		private var mLoadFlag:uint = 0;
		public function get hasLoaded():Boolean { return mLoadFlag == LOAD_FLAG_YES; }
		
		private var mEffects:Vector.<Vector.<EffectFrame>>;
		
		public function DiabloEffectLoader(url:String,postfix:String=".swf")
		{
			mUrl = url;
			mPostfix = postfix;
		}
		
		public static function getSameDiabloLoader(url:String,postfix:String=".swf"):DiabloEffectLoader
		{
			if(dLoaders[url])
			{
				return dLoaders[url] as DiabloEffectLoader;
			}
			var dLoader:DiabloEffectLoader = new DiabloEffectLoader(url);
			dLoaders[url] = dLoader;
			return dLoader;
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
			var numDirect:uint = stream.readUnsignedByte();
			
			mEffects = new Vector.<Vector.<EffectFrame>>(numDirect,true);
			
			for(var i:uint=0;i<numDirect;++i)
			{
				var nunFrames:uint = stream.readUnsignedByte();
				mEffects[i] = new Vector.<EffectFrame>(nunFrames,true);
				for(var j:uint=0;j<nunFrames;++j)
				{
					var frame:EffectFrame = new EffectFrame();
					frame.x = stream.readShort();
					frame.y = stream.readShort();
					var w:uint = stream.readUnsignedShort();
					var h:uint = stream.readUnsignedShort();
					var len:uint = stream.readUnsignedInt();
					var frameBytes:ByteArray = new ByteArray();
					stream.readBytes(frameBytes,0,len);
					frameBytes.inflate();
					var frameData:BitmapData = new BitmapData(w,h,true,0);
					frameData.setPixels(frameData.rect,frameBytes);
					frame.frameData = frameData;
					mEffects[i][j] = frame;
				}
			}
			mLoadFlag = LOAD_FLAG_YES;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function getEffects():Vector.<Vector.<EffectFrame>>
		{
			return mEffects;
		}
	}
}
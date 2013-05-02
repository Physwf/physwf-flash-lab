package com.physwf.components.ui
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class SpriteLoader extends EventDispatcher
	{
		public static const LOAD_FLAG_NO:uint = 0;
		public static const LOAD_FLAG_LOADING:uint = 1;
		public static const LOAD_FLAG_YES:uint = 3;
		
		private static var sLoaders:Dictionary = new Dictionary();
		
		private var mUrl:String;
		private var mPostfix:String;
		
		private var mLoadFlag:uint=0;
		public function get hasLoaded():Boolean { return mLoadFlag == LOAD_FLAG_YES; }
		//								[x,y,w,h]
		private var mSpriteInfo:Vector.<Array>;
		private var mSprite:BitmapData;
		private var mAssets:Vector.<BitmapData>;
		
		public function SpriteLoader(url:String,postfix:String = ".swf")
		{
			mUrl = url;
			mPostfix = postfix;
		}
		
		public static function getSameSpriteLoader(url:String):SpriteLoader
		{
			if(sLoaders[url]) 
			{
				return sLoaders[url] as SpriteLoader;
			}
			var sLoader:SpriteLoader = new SpriteLoader(url);
			sLoaders[url] = sLoader;
			return sLoader;
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
			stream.load(new URLRequest(mUrl));
		}
		
		private function onComplete(e:Event):void
		{
			var stream:URLStream = e.target as URLStream;
			stream.removeEventListener(Event.COMPLETE,onComplete);
			mSpriteInfo = new Vector.<Array>();
			var len:uint = stream.readShort();
			for(var i:int =0;i<len;++i)
			{
				var id:uint = stream.readShort();
				var x:uint = stream.readShort();
				var y:uint = stream.readShort();
				var w:uint = stream.readShort();
				var h:uint = stream.readShort();
				mSpriteInfo[id] = [x,y,w,h];
			}
			var sW:uint = stream.readShort();
			var sH:uint = stream.readShort();
			var sSize:uint = stream.readUnsignedInt();
			var sData:ByteArray = new ByteArray();
			stream.readBytes(sData,0,sSize);
			sData.inflate();
			mSprite = new BitmapData(sW,sH,true,0);
			mSprite.setPixels(new Rectangle(0,0,sW,sH),sData);
			mAssets = new Vector.<BitmapData>(len,true);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function getAsset(id:uint):BitmapData
		{
			if(mAssets[id]) return mAssets[id];
			
			var info:Array = mSpriteInfo[id];
			if(!info) return null;
			var asset:BitmapData = new BitmapData(info[2],info[3],true,0);
			asset.copyPixels(mSprite,new Rectangle(info[0],info[1],info[2],info[3]),new Point());
			mAssets[id] = asset;
			return asset;
		}
	}
}
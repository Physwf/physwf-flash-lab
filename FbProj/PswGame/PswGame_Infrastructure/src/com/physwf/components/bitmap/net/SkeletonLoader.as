package com.physwf.components.bitmap.net {
	import com.physwf.components.bitmap.data.BigKey;
	import com.physwf.components.bitmap.data.BitmapDataPackage;
	import com.physwf.components.bitmap.display.BitmapFrame;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;

	public class SkeletonLoader extends EventDispatcher
	{
		public static const POSTFIX_SWF:String = ".swf";
		public static const KEYNAME:String = "key";

		public var bitmapDataPackageLoaders:Vector.<BitmapDataPackageLoader>;
		
//		private var _directionList:Array;
//		private var _resourceList:Array;
//		private var _mirroringList:Array;
//		private var _offsetList:Array;
		
		private var _url:String;
		private var _urlRequest:URLRequest;
		private var _keyName:String;
		private var _postfix:String;
		
		private var _isCloneMode:Boolean;
		private var _isDynamicMode:Boolean;
		private var _isBigKeyMode:Boolean;
		
		private var _bigKey:BigKey;
		/**
		 * 
		 * @param directionList
		 * @param resourceList
		 * @param mirroringList
		 * @param offsetList
		 * @param url
		 * @param keName
		 * @param postFix
		 * @param isCloneMode
		 * @param isDynamicMode
		 * @param isBigKeyMode
		 * 
		 */		
		public function SkeletonLoader(url:String,keyName:String="key",postFix:String=".swf",isCloneMode:Boolean=false,isDynamicMode:Boolean=false,isBigKeyMode:Boolean=true) 
		{
			init(url,keyName,postFix,isCloneMode,isDynamicMode,isBigKeyMode);
		}
		
		private function init(url:String,keyName:String="key",postFix:String=".swf",isCloneMode:Boolean=false,isDynamicMode:Boolean=false,isBigKeyMode:Boolean=true):void
		{
			
			_url = url;
			_keyName = keyName;
			_postfix = postFix;
			
			_isCloneMode = isCloneMode;
			_isDynamicMode = isDynamicMode;
			_isBigKeyMode = isBigKeyMode;
			
		}
		
		public static function getSameSkeletonLoader(url:String,keyName:String="key",postFix:String=".swf",isCloneMode:Boolean=false,isDynamicMode:Boolean=false,isBigKeyMode:Boolean=true):SkeletonLoader
		{
			var tag:String =  url;
			var sLoader:SkeletonLoader = SkeletonLoaderPool.getLoader(tag);
			if(!sLoader)
			{
				sLoader = new SkeletonLoader(url,keyName,postFix,isCloneMode,isDynamicMode,isBigKeyMode);
				SkeletonLoaderPool.addLoader(tag,sLoader);
			}
			return sLoader;
		}
		/**
		 * 获取指定方向，指定名称的动作 
		 * @param direction 动作的方向
		 * @param label 动作的名称
		 * @return 
		 * 
		 */		
		public function getAction(direction:String,label:String):Vector.<BitmapFrame>
		{
			if(_bigKey.directions.indexOf(direction)>-1)
			{
				for(var i:int=0;i<bitmapDataPackageLoaders.length;++i)
				{
					if(bitmapDataPackageLoaders[i].name == direction)
					{
						if(bitmapDataPackageLoaders[i].getLoadStatus(label) == BitmapDataPackageLoader.LOAD_STATUS_NO)
						{
							bitmapDataPackageLoaders[i].loadFrame(label);
						}
						return bitmapDataPackageLoaders[i].bitmapDataPackage.bitmapFrames;
					}
				}
			}
			return null;
		}
		/**
		 * 获取指定方向的某一动作集
		 * @param direction 动作的方向
		 * @param labels 动作名称集
		 * @return 
		 * 
		 */		
		public function getActionGroup(direction:String,labels:Array):Vector.<Vector.<BitmapFrame>>
		{
			return null;
		}
		
		public function load():void
		{
			var request:URLRequest = new URLRequest(_url+"/"+_keyName+_postfix);
			var urlStream:URLStream = new URLStream();
			urlStream.addEventListener(Event.COMPLETE,function(e:Event):void
			{
				var bigKeyData:ByteArray = new ByteArray();
				urlStream.readBytes(bigKeyData,0,urlStream.bytesAvailable);
				_bigKey = new BigKey();
				bigKeyData.position = 0;
				_bigKey.readKey(bigKeyData);
				loadSmallKeys();
				dispatchEvent(new Event(Event.COMPLETE));
			});
			urlStream.load(request);
		}
		
		private function loadSmallKeys():void
		{
			bitmapDataPackageLoaders = new Vector.<BitmapDataPackageLoader>;
			for(var i:int = 0;i<_bigKey.directions.length;++i)
			{
				var bLoader:BitmapDataPackageLoader = new BitmapDataPackageLoader(_url,_bigKey.directions[i]);
				bitmapDataPackageLoaders.push(bLoader);
				bLoader.loadSmallKey();
			}
		}
	} // end class
} // end package
package com.physwf.components.bitmap.net {
	import com.physwf.components.bitmap.data.BigKey;
	import com.physwf.components.bitmap.data.BitmapDataPackage;
	import com.physwf.components.bitmap.display.BitmapFrame;
	import com.physwf.components.bitmap.events.PackageEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;

	public class SkeletonLoader extends EventDispatcher
	{
		public static const POSTFIX_SWF:String = ".swf";
		public static const KEYNAME:String = "key";
		public static const LABEL_DIRECT_PREFIX:String = "d";//方向标签前缀
		public static const LABEL_ACTION_PREFIX:String = "a";//动作标签前缀
		
		public static const LOAD_FLAG_NO:uint = 0;
		public static const LOAD_FLAG_LOADING:uint = 1;
		public static const LOAD_FLAG_YES:uint = 3;
		
		public var bitmapDataPackageLoaders:Vector.<BitmapDataPackageLoader>;
		
		private var _url:String;
		private var _keyName:String;
		private var _postfix:String;
		
		private var _isCloneMode:Boolean;
		private var _isDynamicMode:Boolean;
		private var _isBigKeyMode:Boolean;
		
		private var _isNude:Boolean = false; //是否是裸模
		private var _loaded:Boolean = false;
		private var _loadFlag:uint = LOAD_FLAG_NO;
		
		private var _numInited:uint = 0;//当前已经初始化完毕的packageLoader个数
		private var _bigKey:BigKey;
		
		public function get loadFlag():uint { return _loadFlag; }
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
		 * 通过角色方向标示和动作标示获取动作序列
		 * @param direction 动作的方向
		 * @param action 动作的名称
		 * @return 
		 * 
		 */		
		public function getCharacterAction(direction:uint,action:uint):Vector.<BitmapFrame>
		{
			var directLabel:String = LABEL_DIRECT_PREFIX + direction;
			var actionLabel:String = LABEL_ACTION_PREFIX + action;
			return getAction(directLabel,actionLabel);
		}
		/**
		 * 通过原件名和动作名来获取动作帧序列
		 * @param directLabel
		 * @param actionLabel
		 * @return 
		 * 
		 */		
		public function getAction(directLabel:String,actionLabel:String):Vector.<BitmapFrame>
		{
			if(_bigKey.directions.indexOf(directLabel)>-1)
			{
				for(var i:int=0;i<bitmapDataPackageLoaders.length;++i)
				{
					if(bitmapDataPackageLoaders[i].name == directLabel)
					{
						if(bitmapDataPackageLoaders[i].getLoadStatus(actionLabel) == BitmapDataPackageLoader.LOAD_STATUS_NO)
						{
							bitmapDataPackageLoaders[i].loadFrame(actionLabel);
						}
						return bitmapDataPackageLoaders[i].getPackage(actionLabel).bitmapFrames;
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
		
		public function loadNude():void
		{

			_isNude = true;
			load();
		}
		
		public function load():void
		{
			//判断加载状态
			if(_loadFlag == LOAD_FLAG_YES)
			{
				dispatchEvent(new PackageEvent(PackageEvent.PACKAGE_ALL_INITED));
				return;
			}
			else if(_loadFlag == LOAD_FLAG_LOADING)
			{
				return;
			}
			else
			{
				_loadFlag = LOAD_FLAG_LOADING;
			}
			
			
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
				bLoader.addEventListener(PackageEvent.PACKAGE_INITED,onPackageEvent);
			}
		}
		
		private function onPackageEvent(e:PackageEvent):void
		{
			var bLoader:BitmapDataPackageLoader = e.target as BitmapDataPackageLoader;
			bLoader.removeEventListener(PackageEvent.PACKAGE_INITED,onPackageEvent);
			_numInited++;
			if(_numInited == _bigKey.directions.length)
			{
				_loadFlag = LOAD_FLAG_YES;
				dispatchEvent(new PackageEvent(PackageEvent.PACKAGE_ALL_INITED));
			}
			if(!_isNude) return;
			var labels:Vector.<String> = bLoader.getFrameNames();
			for(var i:int=0;i<labels.length;++i)
			{
				bLoader.loadFrame(labels[i]);
			}
		}
	} // end class
} // end package
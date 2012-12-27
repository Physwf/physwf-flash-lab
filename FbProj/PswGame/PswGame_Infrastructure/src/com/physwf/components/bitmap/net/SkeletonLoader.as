package com.physwf.components.bitmap.net {
	import com.physwf.components.bitmap.data.BigKey;
	import com.physwf.components.bitmap.display.BitmapFrame;
	
	import flash.net.URLRequest;

	public class SkeletonLoader 
	{
		public static const POSTFIX_SWF:String = ".swf";
		public static const KEYNAME:String = "key";

		public var bitmapDataPackageLoaders:Vector.<BitmapDataPackageLoader>;
		
		private var _directionList:Array;
		private var _resourceList:Array;
		private var _mirroringList:Array;
		private var _offsetList:Array;
		
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
		public function SkeletonLoader(directionList:Array,resourceList:Array,mirroringList:Array,offsetList:Array,url:String,keyName:String="key",postFix:String=".swf",isCloneMode:Boolean=false,isDynamicMode:Boolean=false,isBigKeyMode:Boolean=true) 
		{
			init(directionList,resourceList,mirroringList,offsetList,url,keyName,postFix,isCloneMode,isDynamicMode,isBigKeyMode);
		}
		
		private function init(directionList:Array,resourceList:Array,mirroringList:Array,offsetList:Array,url:String,keyName:String="key",postFix:String=".swf",isCloneMode:Boolean=false,isDynamicMode:Boolean=false,isBigKeyMode:Boolean=true):void
		{
			if(!directionList || !directionList.length)
			{
				throw "direction列表不能为空";
			}
			if(!resourceList || !resourceList.length)
			{
				throw "resourceList列表不能为空";
			}
			_directionList = directionList.concat();
			_resourceList = resourceList?resourceList.concat():new Array(directionList.length);
			_mirroringList = mirroringList?mirroringList.concat():new Array(directionList.length);
			_offsetList = offsetList?offsetList.concat():new Array(directionList.length);
			
			_url = url;
			_keyName = keyName;
			_postfix = postFix;
			
			_isCloneMode = isCloneMode;
			_isDynamicMode = isDynamicMode;
			_isBigKeyMode = isBigKeyMode;
			
			if(directionList.length != resourceList.length || directionList.length != mirroringList.length || directionList.length != offsetList.length)
			{
				throw "参数不匹配";
			}
		}
		
		public static function getSameSkeletonLoader(directionList:Array,resourceList:Array,mirroringList:Array,offsetList:Array,url:String,keyName:String="key",postFix:String=".swf",isCloneMode:Boolean=false,isDynamicMode:Boolean=false,isBigKeyMode:Boolean=true):SkeletonLoader
		{
			var tag:String = directionList + resourceList +mirroringList + url;
			var sLoader:SkeletonLoader = SkeletonLoaderPool.getLoader(tag);
			if(!sLoader)
			{
				sLoader = new SkeletonLoader(directionList,resourceList,mirroringList,offsetList,url,keyName,postFix,isCloneMode,isDynamicMode,isBigKeyMode);
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
		
		public function load(request:URLRequest=null):void
		{
			if(request)
			{
				_urlRequest = request;
				_url = request.url;
			}
			else
			{
				_urlRequest = new URLRequest(_url);
			}
			
			
		}
	} // end class
} // end package
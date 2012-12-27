package com.physwf.components.pswloader
{
	import com.physwf.components.ds.heap.MaxHeap;
	
	import flash.display.MovieClip;
	import flash.net.URLRequest;

	public class PswLoader
	{
		private static var _allLoaders:Object = {};
		private static var _itemPrioList:MaxHeap = new MaxHeap(100);//优先加载队列，所有PswLoader实例共享
		
		private var _myItems:Vector.<LoadingItem>;//当前PswLoader的加载实例
		private var _contents:Object;//当前PswLoader所加载到的项目内容
		
		private var _name:String;
		public function get name():String { return _name;}
		
		private var _typeClasses:Object = 
			{

			};
			
		private var _isFinished:Boolean;
		
		private var _isRunning:Boolean;
		private var _isPaused:Boolean;
		
		/**
		 * 
		 * @param name 实例名称
		 * @param numConnections 最大并发数
		 * 
		 */		
		public function PswLoader($name:String)
		{
			if(_allLoaders[$name])
			{
				throw "[PswLoader]已经有同名的PswLoader存在！";
			}
			else if(!$name)
			{
				throw "[PswLoader]PswLoader的实例名称不能为空！";
			}
			_allLoaders[$name] = this;
			_name = $name;
		}
		
		public function add(url:*,props:Object):LoadingItem
		{
			if(!name) throw "[PswLoader]不能对已经被清除(.clear())的PswLoader添加加载项目！";
			if(!url || !String(url))  throw "url不能为空！";
			if(url is String)
			{
				url = new URLRequest(url);
			}
			else if(!url is URLRequest)
			{
				throw "[PswLoader]不是有效的url类型！";
			}
			
			var item:LoadingItem = get(props["id"]);
			
			if(item) return item;
			
			var type:String;
			if(props["type"])
			{
				type = props["type"].toLowerCase();
			}
			if(!type)
			{
				// guess type
			}
			item = new _typeClasses[type](url,type);
			
			item._parseOptions(props);
			
			_myItems.push(item);
			_isFinished = false;
			
			return item;
		}
		
		internal function _loadNext(item:LoadingItem):Boolean
		{
			if(_isFinished) return false;
			
			var next:Boolean = false;
			return next;
		}
		
		public function start(onAllComplete:Function=null):void
		{
			
		}
		
		public function get(key:*):LoadingItem
		{
			return null;
		}
			
		
		public function clear():void
		{
			delete _allLoaders[name];
			_name =null;
		}
			
	}
}
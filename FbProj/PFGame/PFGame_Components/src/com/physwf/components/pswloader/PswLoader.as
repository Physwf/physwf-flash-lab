package com.physwf.components.pswloader
{
	import com.physwf.components.ds.heap.MaxHeap;
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.interfaces.INumerical;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	import mx.collections.errors.ItemPendingError;

	/**
	 * 该Loader参考了BulkLoader的设计，但进行了一定程度的简化。 
	 * @author joe
	 * 
	 */
	public class PswLoader extends EventDispatcher implements IDisposible
	{
		public static const TYPE_BINARY:String = "binary";
		public static const TYPE_IMAGE:String = "image";
		public static const TYPE_PIECE:String = "piece";
		
		public static const PRIORITY_DEFAULT:Number = 5;
		
		private static var _allLoaders:Object = {};//所有的PswLoader实例
		private static var _numInstance:uint;//实例数
		private static var _itemPrioList:MaxHeap = new MaxHeap(200);//优先加载队列，所有PswLoader实例共享
		/**
		 * 最大并发数,当最大并发数改变时，PswLoader不会立即清理多出的加载线程
		 */		
		public static var maxConnections:uint = 10;
		/**
		 * 当前并发数，一般不会超过最大并发数，除非最大并发数主动改变，以至于大于最大并发数。此时numConnection不会增加，而是逐渐降低到最大并发数
		 */		
		private static var numConnection:uint;
		
		private var mItems:Object;//当前PswLoader的加载实例
		private var mNumItems:uint;
		private var mWaitItems:Vector.<LoadingItem>;//当前PswLoader正在等待start的加载项
		private var mNumConnections:uint;//当前PswLoader实例占据的链接数
		private var mContents:Object;//当前PswLoader所加载到的项目内容
		
		private var mName:String;
		public function get name():String { return mName;}
		
		private var mMode:String;
		public function getMode():String { return mMode; }
		
		private var _typeClasses:Object = 
			{
				binary: BinaryItem,
				image:ImageItem,
				piece:PieceItem
			};
		
		public static const LOAD_FLAG_FINISHED:uint = 0;
		public static const LOAD_FLAG_LOADING:uint = 1;
		public static const LOAD_FLAG_PAUSED:uint = 3;
		
		public static const MODE_AUTO:String = "auto";
		public static const MODE_MANU:String = "manu";
		
		private var mLoadFlag:uint;
		/**
		 *  
		 * @param $name
		 * @param mode 加载模式，手动manu 自动 auto
		 * 
		 */
		public function PswLoader(name:String,mode:String="manu")
		{
			if(_allLoaders[name])
			{
				throw "[PswLoader]已经有同名的PswLoader存在！";
			}
			else if(!name)
			{
				throw "[PswLoader]PswLoader的实例名称不能为空！";
			}
			_allLoaders[name] = this;
			mName = name;
			mMode = mode;
			_numInstance ++;
			
			mItems = {};
			mWaitItems = new Vector.<LoadingItem>();
			mContents = {};
		}
		
		public static function getPswLoader(name:String,mode:String="manu"):PswLoader
		{
			if(!_allLoaders[name]) 
			{
				_allLoaders[name] = new PswLoader(name,mode);
			}
			return _allLoaders[name] as PswLoader;
		}
		
		public static function getUniqueName():String
		{
			return "Pl" + _numInstance;
		}
		
		public function add(url:String,priority:Number,type:String=null,...args):LoadingItem
		{
			//already exist
			if(mItems[url]) return mItems[url] as LoadingItem;
			type ||= guessType(url);
			var TypeClass:Class = _typeClasses[type];
			var item:LoadingItem = new TypeClass(url,_numInstance.toString(16)+"_"+mNumItems.toString(16),args);
			mNumItems++;
			
			mItems[url] = item;
			item.priority = priority;
			//只在两种情况下立即进入队列 1,正在加载 2,已经暂停并且加载模式为手动
			if(mMode == MODE_AUTO && mLoadFlag != LOAD_FLAG_PAUSED)
			{
				_itemPrioList.Enqueue(item);
				
				if(mLoadFlag != LOAD_FLAG_LOADING) 
				{
					_loadNext();
				}
			}
			else
			{
				mWaitItems.push(item);
			}
			return item;
		}
		
		private function _loadNext():void
		{
			if(mLoadFlag == LOAD_FLAG_PAUSED) return;//paused
			
			if(numConnection<maxConnections && _itemPrioList.size > 0)
			{
				var item:LoadingItem = _itemPrioList.Dequeue() as LoadingItem;
				if(item.isDistroyed) 
				{
					_loadNext();
					return;
				}
				item.addEventListener(Event.COMPLETE,onItemComplete,false,int.MAX_VALUE);
				item.load();
				
				numConnection++;
				mNumConnections++;
				
				_loadNext();
			}
		}
		
		private function onItemComplete(e:Event):void
		{
			var item:LoadingItem = e.target as LoadingItem;
			item.removeEventListener(Event.COMPLETE,onItemComplete);
			mContents[item.url] = item.getContent();
			trace(item.url);
			numConnection--;
			mNumConnections --;
			
			_loadNext();
			
			delete mItems[item.url];
			mNumItems --;
			
			if(mNumItems == 0)
			{
				mLoadFlag = LOAD_FLAG_FINISHED;
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function start():void
		{
			if(mLoadFlag == LOAD_FLAG_LOADING) return;
			if(mLoadFlag == LOAD_FLAG_FINISHED)
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
			for(var i:uint=0;i<mWaitItems.length;++i)
			{
				_itemPrioList.Enqueue(mWaitItems[i]);
			}
			mWaitItems = new Vector.<LoadingItem>();
			mLoadFlag = LOAD_FLAG_LOADING;
			_loadNext();
		}
		/**
		 * 暂停。该方法不会停止已经正在加载的项目，而只是保证不会再将当前的PswLoader的未加载项目放入加载队列
		 */		
		public function pause():void
		{
			mLoadFlag = LOAD_FLAG_PAUSED;
		}
			
		public function getXML(key:*):XML
		{
			return mContents[key] as XML;
		}
		
		public function getImage(key:*):Bitmap
		{
			return mContents[key] as Bitmap;
		}
		
		public function getSound(key:*):Sound
		{
			return mContents[key] as Sound;
		}
		
		public function getBinary(key:*):ByteArray
		{
			return mContents[key] as ByteArray;
		}
		
		public function getApplication(key:*):Sprite
		{
			return mContents[key] as Sprite;
		}
		
		public static function guessType(url:String):String
		{
			var searchString : String = url.indexOf("?") > -1 ? 
				url.substring(0, url.indexOf("?")) : 
				url;
			var finalPart : String = searchString.substring(searchString.lastIndexOf("/"));;
			var extension : String = finalPart.substring(finalPart.lastIndexOf(".") + 1).toLowerCase();
			var type : String;
			return type;
		}
		
		public function destroy():void
		{
			delete _allLoaders[mName];
			var item:LoadingItem;
			for (var key:String in mItems)
			{
				item = mItems[key];
				delete mItems[key];
				item.removeEventListener(Event.COMPLETE,onItemComplete);
				item.stop();
				item.destroy();
			}
			
			numConnection -= mNumConnections;
			_numInstance--;
			
			mName = null;
			mContents = null;
		}
	}
}
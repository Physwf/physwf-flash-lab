package components.bitmap.net
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import components.bitmap.data.Key;
	import components.bitmap.display.BitmapFrame;
	import components.character.enum.CharacterAction;
	import components.pswloader.BinaryFile;
	import components.pswloader.PswLoader;
	import components.resource.ResourceCache;

	public class SkeletonLoader extends ResourceCache
	{
		private static var skLoaders:Dictionary = new Dictionary();
		public static const LOAD_FLAG_NO:uint = 0;
		public static const LOAD_FLAG_LOADING:uint = 1;
		public static const LOAD_FLAG_YES:uint = 3;
		/*每一个BitmapDataPackageLoader对应一个目录，用来加载相应目录下的位图资源*/
		public var actionPackageLoaders:Vector.<ActionPackageLoader>;
		
		private var _url:String;
		private var _keyName:String;
		private var _postfix:String;
		
		private var _isNude:Boolean = false; //是否是裸模
		private var _loaded:Boolean = false;
		private var _loadFlag:uint = LOAD_FLAG_NO;
		
		private var _numInited:uint = 0;//当前已经初始化完毕的packageLoader个数
		
		public function get loadFlag():uint { return _loadFlag; }

		
		public function SkeletonLoader(url:String)
		{
			_url = url;
		}
		
		public static function getSameSkeletonLoader(url:String):SkeletonLoader
		{
			var sLoader:SkeletonLoader =skLoaders[url];
			if(!sLoader)
			{
				sLoader = new SkeletonLoader(url);
				skLoaders[url] = sLoader;
			}
			sLoader.incRefCount();
			return sLoader;
		}
		
		public function getAction(direction:uint,actionName:String):Vector.<BitmapFrame>
		{
			for(var i:int=0;i<actionPackageLoaders.length;++i)
			{
				if(actionPackageLoaders[i].name == actionName)
				{
					actionPackageLoaders[i].load();
					return actionPackageLoaders[i].actionPackage[direction];
				}
			}
			return null;
		}
		
		public function load():void
		{
			//判断加载状态
			if(_loadFlag == LOAD_FLAG_YES)
			{
				dispatchEvent(new Event(Event.COMPLETE));
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
			var pLoader:PswLoader = PswLoader.getSamePswLoader("skeleton");
			var keyFile:BinaryFile = pLoader.add(_url+"/key.swf",1,PswLoader.TYPE_BINARY)  as BinaryFile;
			keyFile.addEventListener(Event.COMPLETE,onKeyComplete);
			pLoader.start();
		}
		
		private function onKeyComplete(e:Event):void
		{
			var keyFile:BinaryFile = e.target as BinaryFile;
			keyFile.removeEventListener(Event.COMPLETE,onKeyComplete);
			var key:Key = new Key();
			var keyData:ByteArray = keyFile.getContent() as ByteArray;
			keyData.position = 0;
			keyData.inflate();
			key.readExternal(keyData);
			
			var numActions:uint = key.actionNames.length;
			actionPackageLoaders = new Vector.<ActionPackageLoader>(numActions,true);
			for(var i:uint=0;i<numActions;++i)
			{
				var name:String = key.actionNames[i];
				var id:uint = CharacterAction.nameToId(name);
				actionPackageLoaders[i] = new ActionPackageLoader(_url,name,key.frames[id]);
			}
			_loadFlag = LOAD_FLAG_YES;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		override public function destroy():void
		{
			
		}
	}
}
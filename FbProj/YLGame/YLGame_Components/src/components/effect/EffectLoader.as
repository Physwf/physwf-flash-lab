package components.effect
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import components.bitmap.display.BitmapFrame;
	import components.pswloader.BinaryFile;
	import components.pswloader.PswLoader;
	import components.resource.ResourceCache;
	
	public class EffectLoader extends ResourceCache
	{
		public static const LOAD_FLAG_NO:uint = 0;
		public static const LOAD_FLAG_LOADING:uint = 1;
		public static const LOAD_FLAG_YES:uint = 3;
		
		private static var eLoaders:Dictionary = new Dictionary();
		
		private var mUrl:String;
		private var mFrames:Vector.<BitmapFrame>;
		
		private var mLoadFlag:uint;
		
		public function EffectLoader(url:String)
		{
			mUrl = url;
		}
		
		public static function getSameEffectLoader(url:String):EffectLoader
		{
			var eLoader:EffectLoader = eLoaders[url] as EffectLoader;
			if(eLoader == null)
			{
				eLoader = new EffectLoader(url);
				eLoaders[url] = eLoader;
			}
			eLoader.incRefCount();
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
			var pLoader:PswLoader = PswLoader.getSamePswLoader("effect");
			var eFile:BinaryFile = pLoader.add(mUrl+".swf",1,PswLoader.TYPE_BINARY) as BinaryFile;
			eFile.addEventListener(Event.COMPLETE,onComplete);
		}
		
		private function onComplete(e:Event):void
		{
			var data:ByteArray = e.target.getContent();
			data.inflate();
			mFrames = new Vector.<BitmapFrame>();
			while(data.bytesAvailable)
			{
				var x:int = data.readShort();
				var y:int = data.readShort();
				var w:uint = data.readUnsignedShort();
				var h:uint = data.readUnsignedShort();
				var bytes:ByteArray = new ByteArray();
				data.readBytes(bytes,0,w*h*4);
				var bmd:BitmapData = new BitmapData(w,h,true,0);
				bmd.setPixels(bmd.rect,bytes);
				
				var bFrame:BitmapFrame = new BitmapFrame();
				bFrame.x = x;
				bFrame.y = y;
				bFrame.bitmapData = bmd;
				mFrames.push(bFrame);
			}
			dispatchEvent(new Event(Event.COMPLETE));
			data.clear();
		}
		
		public function getFrames():Vector.<BitmapFrame>
		{
			return mFrames;
		}
	}
}
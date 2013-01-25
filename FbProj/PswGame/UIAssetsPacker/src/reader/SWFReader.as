package reader
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	public class SWFReader extends EventDispatcher implements IReader
	{
		private var file:File;
		private var mData:Vector.<BitmapData>;
		
		public function SWFReader()
		{
		}
		
		public function readFile(path:String):void
		{
			file = new File(path);
			file.addEventListener(Event.COMPLETE,onFileLoaded);
			file.load();
		}
		
		public function readDir():void
		{
		}
		private var loader:Loader
		private function onFileLoaded(e:Event):void
		{
			var data:ByteArray = file.data;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onBytesLoaded);
			var lc:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
			lc.allowCodeImport = true;
			loader.loadBytes(data,lc);
		}
		
		private function onBytesLoaded(e:Event):void
		{
			loader.removeEventListener(Event.COMPLETE,onBytesLoaded);
			var swf:MovieClip = loader.content as MovieClip;
			mData = new Vector.<BitmapData>();
			for(var i:int=0;i<swf.numChildren;++i)
			{
				var mc:MovieClip = swf.getChildAt(i) as MovieClip;
				var bmd:BitmapData = new BitmapData(mc.width,mc.height,true,0);
				bmd.draw(mc);
				data.push(bmd);
			}
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get data():Vector.<BitmapData> { return mData; }
	}
}
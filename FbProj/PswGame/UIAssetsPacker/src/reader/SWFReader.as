package reader
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	public class SWFReader extends EventDispatcher implements IReader
	{
		private var files:Vector.<File>;
		private var mData:Vector.<BitmapData>;
		private var mNumComplete:uint = 0;
		
		public function SWFReader()
		{
			files = new Vector.<File>();
			mData = new Vector.<BitmapData>();
		}
		
		public function readFile(path:String):void
		{
			var file:File = new File(path);
			files.push(file);
			file.addEventListener(Event.COMPLETE,onFileLoaded);
			file.load();
		}
		
		public function readDir(paths:Vector.<File>):void
		{
			for(var i:int=0;i<paths.length;++i)
			{
				readFile(paths[i].url);
			}
		}
		
		private function onFileLoaded(e:Event):void
		{
			var data:ByteArray = e.target.data;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onBytesLoaded);
			var lc:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain,null);
			lc.allowCodeImport = true;
			loader.loadBytes(data,lc);
		}
		
		private function onBytesLoaded(e:Event):void
		{
			var lInfo:LoaderInfo = e.target as LoaderInfo;
			var swf:MovieClip = lInfo.content as MovieClip;
			for(var i:int=0;i<swf.numChildren;++i)
			{
				var mc:MovieClip = swf.getChildAt(i) as MovieClip;
				var bmd:BitmapData = new BitmapData(mc.width,mc.height,true,0);
				bmd.draw(mc);
				data.push(bmd);
			}
			mNumComplete++;
			if(mNumComplete == files.length)
				dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get data():Vector.<BitmapData> { return mData; }
		
		public function clear():void
		{
			files = new Vector.<File>();
			mData = new Vector.<BitmapData>();
		}
	}
}
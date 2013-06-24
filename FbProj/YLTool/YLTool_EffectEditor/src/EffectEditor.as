package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import spark.components.Application;
	import spark.components.Window;
	
	import common.interfaces.ITool;

	public class EffectEditor implements ITool
	{
		private var win:Window;
		private var config:XML;
		private var appDir:File;
		private var configFile:File;
		private var effectInputDir:File;
		private var effettOutputDir:File;
		private var jsonFiles:Dictionary;
		private var pngFiles:Dictionary;
		private var effectNames:Vector.<String>;
		private var jsonObjects:Dictionary;
		private var pngDatas:Dictionary;
		
		public function EffectEditor()
		{
		}
		
		public function execute(root:Application):void
		{
			win = new Window();
			win.width = 500;
			win.height = 200;
			
			win.open();
			
			appDir = File.applicationDirectory;
			appDir =new File(appDir.nativePath);
			configFile = appDir.parent.resolvePath("assets/EffectEditor/configs/inout.xml");
			configFile.addEventListener(Event.COMPLETE,onConfigLoaded);
			configFile.load();
		}
		
		private function onConfigLoaded(e:Event):void
		{
			var data:ByteArray = configFile.data;
			config = XML(data.readUTFBytes(data.bytesAvailable));
			effectInputDir = new File( (config.effect[0].@input) );
			var allFiles:Array = effectInputDir.getDirectoryListing();
			jsonFiles = new Dictionary();
			pngFiles = new Dictionary();
			jsonObjects = new Dictionary();
			pngDatas = new Dictionary();
			effectNames = new Vector.<String>();
			seperate(allFiles);
		}
		
		private function seperate(files:Array):void
		{
			for each(var file:File in files)
			{
				var name:String = file.name.split(".")[0];
				
				if(file.extension == "json")
				{
					jsonFiles[name] = file;
					effectNames.push(name);
				}
				else if(file.extension == "png")
				{
					pngFiles[name] = file;
				}
			}
			loadNext();
		}
		
		private function loadNext():void
		{
			if(effectNames.length == 0)
			{
				win.close();
				return;
			}
			var name:String = effectNames.shift();
			trace(name)
			var jsonfile:File = jsonFiles[name] as File;
			var pngFile:File = pngFiles[name] as File;
			jsonfile.addEventListener(Event.COMPLETE,onJsonComplete);
			pngFile.addEventListener(Event.COMPLETE,onPngComplete);
			jsonfile.load();
			pngFile.load();
		}
		
		private function onJsonComplete(e:Event):void
		{
			var file:File = e.target as File;
			var name:String = file.name.split(".")[0];
			jsonObjects[name] = JSON.parse(file.data.readUTFBytes(file.data.bytesAvailable));
			pack(name);
		}
		
		private function onPngComplete(e:Event):void
		{
			var file:File = e.target as File;
			var pngData:ByteArray = file.data;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(e:Event):void
			{
				var name:String = file.name.split(".")[0];
				pngDatas[name] = Bitmap(loader.content).bitmapData;
				pack(name);
			});
			loader.loadBytes(pngData);
		}
		
		private function pack(name:String):void
		{
			if(jsonObjects[name] == null) return;
			if(pngDatas[name] == null) return;
			var sheet:BitmapData = pngDatas[name] as BitmapData;
			var frames:Array = jsonObjects[name].frames;
			var effectData:ByteArray = new ByteArray();
			
			for(var i:uint=0;i<frames.length;++i)
			{
				var x:int =  frames[i].spriteSourceSize.x - frames[i].sourceSize.w/2;
				var y:int = frames[i].spriteSourceSize.y;
				var w:uint = frames[i].frame.w;
				var h:uint = frames[i].frame.h;
				var rect:Rectangle = new Rectangle(frames[i].frame.x,frames[i].frame.y,w,h);
				var bytes:ByteArray = sheet.getPixels(rect);
				
				effectData.writeShort(x);
				effectData.writeShort(y);
				effectData.writeShort(w);
				effectData.writeShort(h);
				effectData.writeBytes(bytes);
			}
			effectData.deflate();
			
			var file:File = new File((config.effect[0].@output) + "/" + name + ".swf");
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeBytes(effectData);
			fs.close();
			
			loadNext();
		}
		
		public function exit():void
		{
			// TODO Auto Generated method stub
		}
		
	}
}
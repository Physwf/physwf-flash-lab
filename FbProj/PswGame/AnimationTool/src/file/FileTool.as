package file
{
	import com.physwf.components.bitmap.data.BigKey;
	import com.physwf.components.bitmap.data.SmallKey;
	import com.physwf.components.bitmap.net.SkeletonLoader;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import mx.core.Application;
	import mx.core.FlexGlobals;
	
	import parser.JackParser;
	
	import struct.SkeletonStruct;
	
	import writer.ElvesWriter;
	import writer.IWriter;
	import writer.JackWriter;
	import writer.SpriteWriter;

	public class FileTool
	{
		public function FileTool()
		{
		}
		
		private var _file:File;
		private var _stage:Stage;
		
		public function read(stage:Stage):void
		{
			_stage = stage;
			_file = new File();
			_file.addEventListener(Event.SELECT,onFileSelect);
			_file.browse([new FileFilter("Flash Movie","*.swf")]);
		}
		private var _loader:Loader;
		private function onFileSelect(e:Event):void
		{
			_file.removeEventListener(Event.SELECT,onFileSelect);
			_file.addEventListener(Event.COMPLETE,onFileLoaded);
			_file.load();
		}
		
		private function onFileLoaded(e:Event):void
		{
			_file.removeEventListener(Event.COMPLETE,onFileLoaded);
			
			if(_loader)
			{
				_loader.unloadAndStop();
				_loader.parent && _loader.parent.removeChild(_loader);
				_loader = null;
			}
			_loader = new Loader();
			_stage.addChild(_loader);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			var lc:LoaderContext = new LoaderContext();
			lc.allowCodeImport = true;
			_loader.loadBytes(_file.data,lc);
		}
		private var _writer:IWriter;
		
		private function onComplete(e:Event):void
		{
			var swf:MovieClip = e.target.content as MovieClip;
			var rect:Rectangle = swf.getBounds(_loader);
			var x0:Number = (rect.left + rect.right) /2;
			var y0:Number = (rect.top + rect.bottom) /2;
			swf.x = _stage.stageWidth /2 -x0;
			swf.y = _stage.stageHeight /2 -y0;
			var skeletonStruct:SkeletonStruct = JackParser.parseSkeleton(swf,_file.name.split(".")[0]);
			
			switch(FlexGlobals.topLevelApplication.mode) 
			{
				case "Jack":
					if(!_writer || !(_writer is JackWriter))
						_writer = new JackWriter();
					break;
				case "Sprite":
					if(!_writer || !(_writer is SpriteWriter))
						_writer = new SpriteWriter();
					break;
				case "Elves":
					if(!_writer || !(_writer is ElvesWriter))
						_writer = new ElvesWriter();
					break;
			}
			_writer.writeSkeleton(skeletonStruct);
		}
		
		private var _fileStream:FileStream;
		
		private function writeSkeleton(skeletonStruct:SkeletonStruct):void
		{
			_fileStream = new FileStream();
			
			var skeletonName:String = skeletonStruct.name;
			var bigKey:BigKey = new BigKey();
			
			for(var i:int = 0;i<skeletonStruct.mcList.length;++i)
			{
				var mcName:String = skeletonStruct.mcList[i].name;
				var smallKey:SmallKey = new SmallKey();
				for(var j:int =0;j<skeletonStruct.mcList[i].packageList.length;++j)
				{
//					var frameName:String = skeletonStruct.mcList[i].frameList[j].name;
					var frameName:String = skeletonStruct.mcList[i].packageList[j].name;
					smallKey.symbolNames = skeletonStruct.symbolNames;
					smallKey.directionName = skeletonStruct.mcList[i].name;
					smallKey.totalFrames = skeletonStruct.mcList[i].totalFrames;
					
					var rectArr:Array = [];
					var frames:Array = [];
					/*
					for(var k:int =0;k<skeletonStruct.mcList[i].frameList[j].bitmapDataStructList.length;++k)
					{
						rectArr.push(skeletonStruct.mcList[i].frameList[j].bitmapDataStructList[k].w,
									skeletonStruct.mcList[i].frameList[j].bitmapDataStructList[k].h);
						frames.push(skeletonStruct.mcList[i].frameList[j].bitmapDataStructList[k].index,
								skeletonStruct.mcList[i].frameList[j].bitmapDataStructList[k].x,
								skeletonStruct.mcList[i].frameList[j].bitmapDataStructList[k].y);
					}
					*/
					for(var k:int =0;k<skeletonStruct.mcList[i].packageList[j].bitmapKeyFrames.length;++k)
					{
						rectArr.push(skeletonStruct.mcList[i].packageList[j].bitmapKeyFrames[k].rect.width,
							skeletonStruct.mcList[i].packageList[j].bitmapKeyFrames[k].rect.height);
						
					}
					for(k=0;k<skeletonStruct.mcList[i].packageList[j].bitmapFrames.length;++k)
					{
						// to do 计算出index的值
						var index:int = skeletonStruct.mcList[i].packageList[j].bitmapFrames[k].index;
//						index --;
						frames.push(
							index,
							skeletonStruct.mcList[i].packageList[j].bitmapKeyFrames[index].x,
							skeletonStruct.mcList[i].packageList[j].bitmapKeyFrames[index].y);
					}
					
					smallKey.keyFrameLength = rectArr.length;
					smallKey.keyFrameRects = rectArr;
					smallKey.frames = frames;
					
					var bytes:ByteArray = new ByteArray();
//					skeletonStruct.mcList[i].frameList[j].writeFrame(bytes);
					skeletonStruct.mcList[i].packageList[j].writeExternal(bytes);
					var tempFile:File = File.desktopDirectory.resolvePath(skeletonName+"/"+mcName+"/"+frameName+SkeletonLoader.POSTFIX_SWF);
					_fileStream.open(tempFile,FileMode.WRITE);
					_fileStream.writeBytes(bytes);
					_fileStream.close();
					
					bytes = new ByteArray();
					smallKey.writeKey(bytes);
					bigKey.smallKeys.push(bytes);
					tempFile = File.desktopDirectory.resolvePath(skeletonName+"/"+mcName+"/"+SkeletonLoader.KEYNAME+SkeletonLoader.POSTFIX_SWF);
					_fileStream.open(tempFile,FileMode.WRITE);
					_fileStream.writeBytes(bytes);
					_fileStream.close();
				}
				
				var bKeyBytes:ByteArray = new ByteArray();
				bigKey.writeKey(bKeyBytes);
				tempFile = File.desktopDirectory.resolvePath(skeletonName+"/"+SkeletonLoader.KEYNAME+SkeletonLoader.POSTFIX_SWF);
				_fileStream.open(tempFile,FileMode.WRITE);
				_fileStream.writeBytes(bKeyBytes);
				_fileStream.close();
			}
		}
		
	}
}
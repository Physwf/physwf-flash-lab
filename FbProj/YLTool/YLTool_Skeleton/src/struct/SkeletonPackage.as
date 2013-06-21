package struct
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import components.bitmap.data.Key;

	public class SkeletonPackage extends EventDispatcher
	{
		private var mFiles:Array;
		private var mProgress:uint;
		private var mActions:Vector.<String>;
		private var mFrames:Vector.<Vector.<uint>>;
		private var mJSONFiles:Dictionary;
		private var mPNGFiles:Dictionary;
		private var mJSONObjects:Dictionary;
		private var mPNGData:Dictionary;
		private var isBusy:Boolean;
		private var mRelativeDir:String;
		private var mChildrenDir:Vector.<File>;
		
		public function SkeletonPackage(files:Array,rDir:String)
		{
			mFiles = files;
			mActions = new Vector.<String>();
			mJSONFiles = new Dictionary;
			mPNGFiles = new Dictionary;
			mJSONObjects = new Dictionary;
			mPNGData = new Dictionary;
			mRelativeDir = rDir;
			mChildrenDir = new Vector.<File>();
			saperate();
		}
		
		private function saperate():void
		{
			for(var i:uint=0;i<mFiles.length;++i)
			{
				var file:File = mFiles[i] as File;
				if(file.isDirectory)
				{
					mChildrenDir.push(file);
					continue;
				}
				var name:String = file.name.split(".")[0];
				if(file.extension == "json")
				{
					mJSONFiles[name] = file;
					mActions.push(name);
				}
				else if(file.extension == "png")
				{
					mPNGFiles[name] = file;
				}
			}
			mFrames = new Vector.<Vector.<uint>>(8,true)
		}
		
		public function load():void
		{
			loadNext();
		}
		
		private function loadNext():void
		{
			if(isBusy) return;
			
			if(mActions.length == mProgress)
			{
				if(mChildrenDir.length != 0)
				{
					var file:File = mChildrenDir.shift();
					var files:Array = file.getDirectoryListing();
					var sp:SkeletonPackage = new SkeletonPackage(files,mRelativeDir+"/"+file.name);
					sp.addEventListener(Event.COMPLETE,function(e:Event):void
					{
						loadNext();
					});
					sp.load();
					return;
				}
				var fs:FileStream = new FileStream();
				var key:Key = new Key();
				key.actionNames = mActions;
				key.frames = mFrames;
				var keyData:ByteArray = new ByteArray();
				key.writeExternal(keyData);
				keyData.deflate();
				var keyFile:File = new File(Skeleton.rootDir + mRelativeDir + "/key.swf");
				fs.open(keyFile,FileMode.WRITE);
				fs.writeBytes(keyData);
				fs.close();
				
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			
			
			var action:String = mActions[mProgress++];
			var jFile:File = mJSONFiles[action] as File;
			var pFile:File = mPNGFiles[action] as File;
			jFile.addEventListener(Event.COMPLETE,onJSONComplete);
			pFile.addEventListener(Event.COMPLETE,onPNGComplete);
			jFile.load();
			pFile.load();
			isBusy = true;
		}
		
		private function onJSONComplete(e:Event):void
		{
			var file:File = e.target as File;
			var name:String = file.name.split(".")[0];
			mJSONObjects[name] = JSON.parse(file.data.readUTFBytes(file.data.bytesAvailable));
			pack(name);
		}
		
		private function onPNGComplete(e:Event):void
		{
			var file:File = e.target as File;
			var pngData:ByteArray = file.data;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(e:Event):void
			{
				var name:String = file.name.split(".")[0];
				mPNGData[name] = Bitmap(loader.content).bitmapData;
				pack(name);
			});
			loader.loadBytes(pngData);
		}
		
		private function pack(name:String):void
		{
			if(mPNGData[name] == null) return;
			if(mJSONObjects[name] == null) return;
			var sheet:BitmapData = mPNGData[name] as BitmapData;
			var frames:Array = mJSONObjects[name].frames;
			var action:uint = nameToId(name);
			mFrames[action] = new Vector.<uint>(5,true);
			var actionPackage:ByteArray = new ByteArray();
			for each(var frame:Object in frames)
			{
				var fName:String = frame.filename;
				var nameArr:Array = fName.split("/");
				var dir:int = uint(nameArr[0]);
				var index:uint = mFrames[action][dir] ++;
				var x:int =  frame.spriteSourceSize.x - frame.sourceSize.w/2;
				var y:int = frame.spriteSourceSize.y - 340;
				var w:uint = frame.frame.w;
				var h:uint = frame.frame.h;
//				var piece:BitmapData = new BitmapData(frame.frame.w,frame.frame.h,true,0);
//				piece.copyPixels(sheet,new Rectangle(frame.frame.x,frame.frame.y,frame.frame.w,frame.frame.h),new Point());
//				var pngEncode:PNGEncoder = new PNGEncoder();
//				var bytes:ByteArray  = pngEncode.encode(piece);
				var bytes:ByteArray = sheet.getPixels(new Rectangle(frame.frame.x,frame.frame.y,frame.frame.w,frame.frame.h));
				actionPackage.writeByte(dir);
				actionPackage.writeByte(index);
				actionPackage.writeShort(x);
				actionPackage.writeShort(y);
				actionPackage.writeShort(w);
				actionPackage.writeShort(h);
				actionPackage.writeUnsignedInt(bytes.length);
				actionPackage.writeBytes(bytes);
				
			}
			actionPackage.deflate();
			
			var fs:FileStream = new FileStream();
			var actioinFile:File = new File(Skeleton.rootDir + mRelativeDir + "/" + name+".swf");
			fs.open(actioinFile,FileMode.WRITE);
			fs.writeBytes(actionPackage);
			fs.close();
			
			isBusy = false;
			loadNext();
		}
		private var names:Array = ["idle","run","sit","atk01","atk02","death","ride_idle","ride_run"];
		
		private function nameToId(name:String):uint
		{
			return names.indexOf(name)
		}
	}
}
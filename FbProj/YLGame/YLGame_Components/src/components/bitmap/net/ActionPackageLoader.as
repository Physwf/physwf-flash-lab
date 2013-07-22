package components.bitmap.net
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import components.bitmap.display.BitmapFrame;
	import components.pswloader.BinaryFile;
	import components.pswloader.ImageFile;
	import components.pswloader.JSONFile;
	import components.pswloader.PswLoader;

	/**
	 * 一个 ActionPackageLoader对应一个动作序列图文件
	 * @author yuelei.qiao
	 * 
	 */	
	public class ActionPackageLoader extends EventDispatcher
	{
		public static const LOAD_FLAG_NO:uint = 0;
		public static const LOAD_FLAG_LOADING:uint = 1;
		public static const LOAD_FLAG_YES:uint = 3;
		
		public static const emptyFrame:Vector.<BitmapFrame> = Vector.<BitmapFrame>([new BitmapFrame()]);
		
		public static const emptyPack:Vector.<Vector.<BitmapFrame>> = Vector.<Vector.<BitmapFrame>>
			(
				[emptyFrame,emptyFrame,emptyFrame,emptyFrame,emptyFrame]
			);
		
		/*动作序列帧数组，第一维为方向*/
		public var actionPackage:Vector.<Vector.<BitmapFrame>>;
		
		private var mURL:String;
		private var mName:String;
		public function get name():String { return mName; }
		
		private var mData:Object;
		private var mSprite:BitmapData;
		
		private var mLoadStatus:uint;
		
		public function ActionPackageLoader(url:String,name:String,numFrames:Vector.<uint>)
		{
			mURL = url;
			mName = name;
			actionPackage = new Vector.<Vector.<BitmapFrame>>(numFrames.length,true);
			for(var i:uint=0;i<actionPackage.length;++i)
			{
				actionPackage[i] = new Vector.<BitmapFrame>(numFrames[i],true);
				for(var j:uint=0;j<numFrames[i];++j)
				{
					actionPackage[i][j] = new BitmapFrame();
				}
			}
		}
		
		public function load():void
		{
			if(mLoadStatus == LOAD_FLAG_YES)
			{
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			else if(mLoadStatus == LOAD_FLAG_LOADING)
			{
				return;
			}
			else
			{
				mLoadStatus = LOAD_FLAG_LOADING;
			}
			trace("action load start:"+getTimer());
			loadPackage();
//			loadJSON();
//			loadImage();
		}
		
		private function loadPackage():void
		{
			var pswLoader:PswLoader = PswLoader.getSamePswLoader("skeleton");
			var packFile:BinaryFile = pswLoader.add(mURL+"/"+mName + ".swf",PswLoader.PRIORITY_SKELETON,PswLoader.TYPE_BINARY) as BinaryFile;
			packFile.addEventListener(Event.COMPLETE,onPackComplete);
			pswLoader.start();
		}
		
		private function loadJSON():void
		{
			var pswLoader:PswLoader = PswLoader.getSamePswLoader("skeleton");
			var jFile:JSONFile = pswLoader.add(mURL+"/"+mName + ".json",PswLoader.PRIORITY_SKELETON,PswLoader.TYPE_JSON) as JSONFile;
			jFile.addEventListener(Event.COMPLETE,onJSONComplete);
		}
		
		private function loadImage():void
		{
			var pswLoader:PswLoader = PswLoader.getSamePswLoader("skeleton");
			var iFile:ImageFile = pswLoader.add(mURL+"/"+mName + ".png",PswLoader.PRIORITY_SKELETON,PswLoader.TYPE_IMAGE) as ImageFile;
			iFile.addEventListener(Event.COMPLETE,onImageComplete);
		}
		
		private function onJSONComplete(e:Event):void
		{
			trace("jasn load complete:"+getTimer());
			var jFile:JSONFile = e.target as JSONFile;
			jFile.removeEventListener(Event.COMPLETE,onJSONComplete);
			mData = jFile.getContent();
			onAllCompete();
		}
		
		private function onImageComplete(e:Event):void
		{
			trace("png load complete:"+getTimer());
			var iFile:ImageFile = e.target as ImageFile;
			iFile.removeEventListener(Event.COMPLETE,onImageComplete);
			mSprite = iFile.getContent();
			onAllCompete();
		}
		
		private function onPackComplete(e:Event):void
		{
			trace("binary load complete:"+getTimer());
			var start:uint = getTimer();
			var packFile:BinaryFile = e.target as BinaryFile;
			var packData:ByteArray = packFile.getContent();
			packData.position = 0;
			packData.inflate();
			while(packData.bytesAvailable)
			{
				var dir:uint = packData.readUnsignedByte();
				var index:uint = packData.readUnsignedByte();
				var x:int = packData.readShort();
				var y:int = packData.readShort();
				var w:int = packData.readUnsignedShort();
				var h:int = packData.readUnsignedShort();
				var len:uint = packData.readUnsignedInt();
				var pieceData:ByteArray = new ByteArray();
				packData.readBytes(pieceData,0,len);
				var piece:BitmapData = new BitmapData(w,h,true,0xFF0000);
				piece.setPixels(piece.rect,pieceData);
				actionPackage[dir][index].bitmapData = piece;
				actionPackage[dir][index].x = x;
				actionPackage[dir][index].y = y;
			}
			trace(name+" binary parse complete:",getTimer()-start);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onAllCompete():void
		{
			if(!mData || !mSprite) return;
			trace("all load complete:"+getTimer());
			var start:uint = getTimer();
			var frames:Array = mData.frames;
			var indexs:Vector.<int> = new Vector.<int>(5,true);
			for each(var frame:Object in frames)
			{
				var fName:String = frame.filename;
				var nameArr:Array = fName.split("/");
				var dir:int = uint(nameArr[0]);
				var bitmapFrame:BitmapFrame = new BitmapFrame();
				bitmapFrame.x = frame.sourceSize.w/2 - frame.spriteSourceSize.x;
				bitmapFrame.y = - frame.spriteSourceSize.y;
				var bmd:BitmapData = new BitmapData(frame.frame.w,frame.frame.h,true,0);
				bmd.copyPixels(mSprite,new Rectangle(frame.frame.x,frame.frame.y,frame.frame.w,frame.frame.h),new Point());
				bitmapFrame.bitmapData = bmd;
				var i:int = indexs[dir]++;
				actionPackage[dir][i] = bitmapFrame;
			}
			//mSprite.dispose();//to do 销毁大对象
			trace(name+" png parse complete:",getTimer()-start);
			mLoadStatus = LOAD_FLAG_YES;
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
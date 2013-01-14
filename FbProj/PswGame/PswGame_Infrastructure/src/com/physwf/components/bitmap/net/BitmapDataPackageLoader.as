package com.physwf.components.bitmap.net 
{
	import com.physwf.components.bitmap.data.BitmapDataPackage;
	import com.physwf.components.bitmap.data.SmallKey;
	import com.physwf.components.bitmap.display.BitmapFrame;
	import com.physwf.components.bitmap.display.BitmapKeyFrame;
	import com.physwf.components.interfaces.IDisposible;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	

	public class BitmapDataPackageLoader extends URLStream implements IDisposible
	{
		public static const SMALL_KEY_ENDIAN:int=1;
		public static const BIG_KEY_ENDIAN:int=2;
		public static const PACKAGE_ENDIAN_JACK:int=3;
		public static const PACKAGE_ENDIAN_SPRITE:int = 4;
		public static const PACKAGE_ENDIAN_ELVES:int = 5;
		
		public static const LOAD_STATUS_NO:uint = 0;
		public static const LOAD_STATUS_LOADING:uint = 1;
		public static const LOAD_STATUS_YES:uint = 2;
		
		
		public var packages:Vector.<BitmapDataPackage>;
		
		private var _url:String;
		private var _endian:int;
		private var _smallKey:SmallKey;
		private var _name:String;
		
		private var _loadStatus:Dictionary;
		
		public function BitmapDataPackageLoader(url:String,name:String) 
		{
			_url = url;
			_name = name;
			_loadStatus = new Dictionary();
		}
		
		override public function load(request:URLRequest):void
		{
			addEventListener(Event.COMPLETE,onComplete);
			super.load(request);
		}
		
		public function loadSmallKey():void
		{
			load(new URLRequest(_url+"/"+_name+"/"+"key.swf"))
		}
		
		public function loadFrame(name:String):void
		{
			if(_smallKey.frameNames.indexOf(name)>-1)
			{
				_loadStatus[name] = LOAD_STATUS_LOADING;
				addEventListener(Event.COMPLETE,function setStatus(e:Event):void
				{
					_loadStatus[name] = LOAD_STATUS_YES;
				},false,Number.NEGATIVE_INFINITY,true);
				load(new URLRequest(_url+"/"+_name+"/"+name+".swf"));
			}
		}
		
		private function onComplete(e:Event):void
		{
			removeEventListener(Event.COMPLETE,onComplete);
			var data:ByteArray = new ByteArray();
			readBytes(data,0,bytesAvailable);
			_endian = data.readShort();
			
			switch(_endian)
			{
				case SMALL_KEY_ENDIAN:
					_smallKey = new SmallKey();
					_smallKey.readKey(data);
					initPackages();
					break;
				case PACKAGE_ENDIAN_JACK:
					var nameLen:uint = data.readShort();
					var name:String = data.readUTFBytes(nameLen);
					getPackage(name).readExternal(data);;
					break;
			}
		}
		
		private function initPackages():void
		{
			packages = new <BitmapDataPackage>[];
			for(var i:int=0;i<_smallKey.frameNames.length;++i)
			{
				var pack:BitmapDataPackage = new BitmapDataPackage();
				pack.name = _smallKey.frameNames[i];
				pack.bitmapKeyFrames = new Vector.<BitmapKeyFrame>(_smallKey.keyFrameCount[i],true);
				pack.bitmapFrames = new Vector.<BitmapFrame>(_smallKey.frameCount[i],true);
				var count:uint = _smallKey.keyFrameCount[i];
				for(var j:int=0;j<count;++j)
				{
					pack.bitmapKeyFrames[j] = new BitmapKeyFrame();
				}
				count = _smallKey.frameCount[i];
				for(j=0;j<count;++j)
				{
					pack.bitmapFrames[j] = new BitmapFrame();
					pack.bitmapFrames[j].index = j;
					pack.bitmapFrames[j].keyFrame = pack.bitmapKeyFrames[0];
				}
				packages.push(pack);
			}
		}
		
		public function get name():String { return _name; }
		public function getLoadStatus(name:String):uint { return _loadStatus[name]; }
		public function getPackage(name:String):BitmapDataPackage
		{
			for(var i:int=0;i<packages.length;++i)
			{
				if(packages[i].name == name)
					return packages[i];
			}
			return null;
		}
		public function destroy():void
		{
			
		}

	} // end class
} // end package
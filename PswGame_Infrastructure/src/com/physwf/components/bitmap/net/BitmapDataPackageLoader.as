package com.physwf.components.bitmap.net 
{
	import com.physwf.components.bitmap.data.BitmapDataPackage;
	import com.physwf.components.bitmap.data.SmallKey;
	import com.physwf.components.bitmap.display.BitmapFrame;
	import com.physwf.components.bitmap.display.BitmapKeyFrame;
	import com.physwf.components.interfaces.IDisposible;
	import com.physwf.components.pswloader.LoadingItem;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	

	public class BitmapDataPackageLoader extends LoadingItem implements IDisposible
	{
		public static const SMALL_KEY_ENDIAN:int=1;
		public static const BIG_KEY_ENDIAN:int=2;
		public static const PACKAGE_ENDIAN_JACK:int=3;
		public static const PACKAGE_ENDIAN_SPRITE:int = 4;
		public static const PACKAGE_ENDIAN_ELVES:int = 5;
		
		public var bitmapDataPackage:BitmapDataPackage;
		
		private var _url:String;
		private var _endian:int;
		private var _smallKey:SmallKey;
		
		public function BitmapDataPackageLoader(url:String,type:String) 
		{
			super(url,type);
		}
		
		override public function load(request:URLRequest):void
		{
			addEventListener(Event.COMPLETE,onComplete);
			super.load(request);
		}
		
		private function onComplete(e:Event):void
		{
			removeEventListener(Event.COMPLETE,onComplete);
			var data:ByteArray = ByteArray(e.target.data);
			_endian = data.readShort();
			
			switch(_endian)
			{
				case SMALL_KEY_ENDIAN:
					_smallKey = new SmallKey();
					_smallKey.readKey(data);
					initPackage();
					break;
//				case BIG_KEY_ENDIAN:
//					var bigKey:BigKey = new BigKey();
//					bigKey.readKey(data);
//					break;
				case PACKAGE_ENDIAN_JACK:
					bitmapDataPackage.readExternal(data);
					break;
			}
		}
		
		/**
		 * 
		 * 初始化bitmapPackage，为进一步的位图数据填充做准备
		 */		
		private function initPackage():void
		{
			bitmapDataPackage = new BitmapDataPackage();
			var numFrame:int = _smallKey.frames.length / 3;
			bitmapDataPackage.bitmapFrames = new Vector.<BitmapFrame>(numFrame,true);
			bitmapDataPackage.bitmapKeyFrames = new Vector.<BitmapKeyFrame>(_smallKey.keyFrameLength,true);
			var frame:BitmapFrame;
			var keyFrame:BitmapKeyFrame;
			
			for(var i:int =0;i<_smallKey.keyFrameLength;++i)
			{
				keyFrame = new BitmapKeyFrame();
				keyFrame.rect = new Rectangle(0,0,_smallKey.keyFrameRects[2*i],_smallKey.keyFrameRects[2*i+1]);
				keyFrame.bitmapData = new BitmapData(keyFrame.rect.width,keyFrame.rect.height,true,0);
				bitmapDataPackage.bitmapKeyFrames[i] = keyFrame;
			}
			
			for(i =0;i<numFrame;++i)
			{
				frame = new BitmapFrame();
				frame.frame = i;
				frame.index = _smallKey.frames[3*i];
				frame.keyFrame = bitmapDataPackage.bitmapKeyFrames[frame.index]
				bitmapDataPackage.bitmapFrames[i] = frame;
			}
			
		}
		
		public function destroy():void
		{
			
		}

	} // end class
} // end package
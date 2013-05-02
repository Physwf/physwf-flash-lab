package com.physwf.components.pswloader
{
	import com.physwf.components.utils.BMPDecoder;
	import com.physwf.components.utils.TGADecoder;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	/**
	 * 图片项目。
	 * 内置图片格式分析。 
	 * 附注:各种图片的文件头
	 * @author Physwf
	 */
	public class ImageItem extends LoadingItem
	{
		/**
		 * 各种图片文件头 
		 */	
		public static const HEAD_JPG:uint = 0xd8ff;
		
		private static const TYPE_JPG:uint = 1;
		private static const TYPE_PNG:uint = 2;
		private static const TYPE_GIF:uint = 3;
		private static const TYPE_TIF:uint = 4;//暂时没必要
		private static const TYPE_TGA:uint = 5;
		private static const TYPE_BMP:uint = 6;
		
		public function ImageItem(url:String,uid:String,...args)
		{
			super(url,uid);
		}
		
		override public function load():void
		{
			var stream:URLStream = new URLStream();
			stream.addEventListener(Event.COMPLETE,onComplete);
			stream.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			stream.load(new URLRequest(mUrl));
		}
		
		
		private function onComplete(e:Event):void
		{
			var stream:URLStream = e.target as URLStream;
			stream.removeEventListener(Event.COMPLETE,onComplete);
			stream.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
			var data:ByteArray = new ByteArray();
			stream.readBytes(data);
			data.endian = Endian.LITTLE_ENDIAN;
			
			switch(analyze(data))
			{
				case TYPE_JPG:
				case TYPE_PNG:
				case TYPE_GIF:
					var loader:Loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete);
					loader.loadBytes(data);
					break;
				case TYPE_TGA:
					var tgaDecoder:TGADecoder = new TGADecoder();
					tgaDecoder.decode(data);
					mContent = tgaDecoder.bitmap;
					dispatchEvent(new Event(Event.COMPLETE));
					break;
				case TYPE_BMP:
					var bmpDecoder:BMPDecoder = new BMPDecoder();
					bmpDecoder.decode(data);
					mContent = bmpDecoder.bitmap;
					dispatchEvent(new Event(Event.COMPLETE));
					break;
				default:
					trace(this,"unsupported image format!!");
					dispatchEvent(new Event(Event.COMPLETE));
					break;
			}
			
			
		}
		/**
		 * 	 * 1.JPEG
		- 文件头标识 (2 bytes): $ff, $d8 (SOI) (JPEG 文件标识) 
		- 文件结束标识 (2 bytes): $ff, $d9 (EOI) 
		2.TGA
		- 未压缩的前5字节   00 00 02 00 00
		- RLE压缩的前5字节   00 00 10 00 00
		3.PNG
		- 文件头标识 (8 bytes)   89 50 4E 47 0D 0A 1A 0A
		4.GIF
		- 文件头标识 (6 bytes)   47 49 46 38 39(37) 61
		                       G  I  F  8  9 (7)  a
		5.BMP
		- 文件头标识 (2 bytes)   42 4D
		                       B  M
		6.PCX
		- 文件头标识 (1 bytes)   0A
		7.TIFF
		- 文件头标识 (2 bytes)   4D 4D 或 49 49
		8.ICO
		- 文件头标识 (8 bytes)   00 00 01 00 01 00 20 20 
		9.CUR
		- 文件头标识 (8 bytes)   00 00 02 00 01 00 20 20
		10.IFF
		- 文件头标识 (4 bytes)   46 4F 52 4D
		                       F  O   R  M
		11.ANI
		- 文件头标识 (4 bytes)   52 49 46 46
								R I  F  F
		 */		
		private function analyze(data:ByteArray):uint
		{
			if(TGADecoder.isTGA(data)) return TYPE_TGA;
			if(BMPDecoder.isBMP(data)) return TYPE_BMP;
			//jpg
			data.position = 0;
			if(data.readUnsignedShort() == HEAD_JPG) return TYPE_JPG;
			//png
			data.position = 0;
			if(data.readUnsignedInt() == 0x89504E47 && data.readUnsignedInt() == 0x0D0A1A0A) return TYPE_PNG;
			//gif
			data.position = 0;
			var gif4:uint = data.readUnsignedInt();
			var gif2:uint = data.readUnsignedShort();
			if(gif4 == 0x47494638 && (gif2 == 0x3961 || gif2 == 0x3761) ) return TYPE_GIF;
			//tif
			data.position = 0;
			var tif:uint = data.readUnsignedShort();
			if(tif == 0x4D4D || tif == 0x4949) return TYPE_TIF;
			// unsupported
			return 0
		}
		
		private function onLoaderComplete(e:Event):void
		{
			var target:LoaderInfo = e.target as LoaderInfo;
			target.removeEventListener(Event.COMPLETE,onLoaderComplete);
			mContent = Bitmap(target.loader.content).bitmapData;
			target.loader.unload();
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
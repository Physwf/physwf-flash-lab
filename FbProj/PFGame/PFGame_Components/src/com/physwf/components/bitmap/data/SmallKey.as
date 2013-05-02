package com.physwf.components.bitmap.data
{
	import com.physwf.components.bitmap.net.BitmapDataPackageLoader;
	
	import flash.display.FrameLabel;
	import flash.sampler.getSize;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class SmallKey
	{
		public var endian:int = BitmapDataPackageLoader.SMALL_KEY_ENDIAN;
		
		public var frameNamesLen:uint;
		public var frameNames:Vector.<String> = new <String>[];
		public var totalFrames:int;
		
		public var keyFrameCount:Array;
		public var frameCount:Array;
		
		public var offsetX:int;
		public var offsetY:int;
		
		public var keyFrameLength:int;
		
//		public var keyFrameRects:Array;//[w1,h1,w2,h2,...]
//		
//		public var frames:Array;//[index1,x1,y1,index2,x2,y2...	]
		
		public function SmallKey()
		{
		}
		
		public function readKey(input:IDataInput):void
		{
			totalFrames = input.readShort();
			
			frameNamesLen = input.readShort();
			frameNames = Vector.<String>(input.readUTFBytes(frameNamesLen).split(","));
			
			offsetX = input.readShort();
			offsetY = input.readShort();
			
			var keyCountLen:uint = input.readShort();
			keyFrameCount = [];
			for(var i:int=0;i<keyCountLen;++i)
			{
				keyFrameCount.push(input.readShort());
			}
			
			var frameCountLen:uint = input.readShort();
			frameCount = [];
			for(i=0;i<frameCountLen;++i)
			{
				frameCount.push(input.readShort());
			}
			
//			keyFrameLength = input.readShort();
//			
////			keyFrameRects = [];
////			for(i=0;i<keyFrameLength;i++)
////			{
////				keyFrameRects[2*i] = input.readShort();
////				keyFrameRects[2*i+1] = input.readShort();
//////				trace(keyFrameRects[2*i]);
//////				trace(keyFrameRects[2*i]+i);
////			}
////			frames = [];
////			for(i=0;input.bytesAvailable;i++)
////			{
////				frames[3*i] = input.readShort();
////				frames[3*i+1] = input.readShort();
////				frames[3*i+2] = input.readShort();
////			}
		}
		
		public function writeKey(output:IDataOutput):void
		{
			output.writeShort(endian);
			output.writeShort(totalFrames);
			
			var frameNamesData:ByteArray = new ByteArray();
			frameNamesData.writeUTFBytes(frameNames.join(","));
			output.writeShort(frameNamesData.length);
			output.writeBytes(frameNamesData);
			
			output.writeShort(offsetX);
			output.writeShort(offsetY);
			
			output.writeShort(keyFrameCount.length);
			for(var i:int=0;i<keyFrameCount.length;++i)
			{
				output.writeShort(keyFrameCount[i]);
			}
			
			output.writeShort(frameCount.length);
			for(i=0;i<frameCount.length;++i)
			{
				output.writeShort(frameCount[i]);
			}
			
//			
//			output.writeShort(keyFrameLength);
//			for(i=0;i<keyFrameLength;i++)
//			{
//				output.writeShort(keyFrameRects[2*i]);
//				output.writeShort(keyFrameRects[2*i+1]);
//				trace(keyFrameRects[2*i],keyFrameRects[2*i+1]);
//			}
//			
//			for(i=0;i<frames.length/3;i++)
//			{
//				output.writeShort(frames[3*i]);
//				output.writeShort(frames[3*i+1]);
//				output.writeShort(frames[3*i+2]);
//			}
			
		}
	}
}
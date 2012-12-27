package com.physwf.components.bitmap.data
{
	import com.physwf.components.bitmap.net.BitmapDataPackageLoader;
	
	import flash.sampler.getSize;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class SmallKey
	{
		public var endian:int = BitmapDataPackageLoader.SMALL_KEY_ENDIAN;
		
		public var nameLen:int;
		public var symbolNames:String;
		
		public var directionNameLen:int;
		public var directionName:String
		
		public var totalFrames:int;
		
		public var offsetX:int;
		public var offsetY:int;
		
		public var keyFrameLength:int;
		
		public var keyFrameRects:Array;//[w1,h1,w2,h2,...]
		
		public var frames:Array;//[index1,x1,y1,index2,x2,y2...	]
		
		public function SmallKey()
		{
		}
		
		public function readKey(input:IDataInput):void
		{
			
			nameLen = input.readShort();
			symbolNames = input.readUTFBytes(nameLen);
			
			directionNameLen = input.readShort();
			directionName = input.readUTFBytes(directionNameLen);
			
			totalFrames = input.readShort();
			
			offsetX = input.readShort();
			offsetY = input.readShort();
			
			keyFrameLength = input.readShort();
			
			keyFrameRects = [];
			for(var i:int =0;i<keyFrameLength;i+=2)
			{
				keyFrameRects[i] = input.readShort();
				keyFrameRects[i+1] = input.readShort();
			}
			frames = [];
			for(i=0;input.bytesAvailable;i+=3)
			{
				frames[i] = input.readShort();
				frames[i+1] = input.readShort();
				frames[i+2] = input.readShort();
			}
		}
		
		public function writeKey(output:IDataOutput):void
		{
			output.writeShort(endian);
			
			nameLen = getSize(symbolNames);
			output.writeShort(nameLen);
			output.writeUTF(symbolNames);
			
			directionNameLen = getSize(directionName);
			output.writeShort(directionNameLen);
			output.writeUTF(directionName);
			
			output.writeShort(totalFrames);
			
			output.writeShort(offsetX);
			output.writeShort(offsetY);
			
			output.writeShort(keyFrameLength);
			for(var i:int =0;i<keyFrameLength;i+=2)
			{
				output.writeShort(keyFrameRects[i]);
				output.writeShort(keyFrameRects[i+1]);
			}
			
			for(i=0;i<frames.length;i+=3)
			{
				output.writeShort(frames[i]);
				output.writeShort(frames[i+1]);
				output.writeShort(frames[i+2]);
			}
			
		}
	}
}
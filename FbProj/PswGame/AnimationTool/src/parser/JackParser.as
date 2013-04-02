package parser
{
	import com.physwf.components.bitmap.data.BitmapDataPackage;
	import com.physwf.components.bitmap.display.BitmapFrame;
	import com.physwf.components.bitmap.display.BitmapKeyFrame;
	
	import flash.display.BitmapData;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import struct.McStruct;
	import struct.SkeletonStruct;

	public class JackParser
	{
		public function JackParser()
		{
		}
		
		public static function parseSkeleton(swfFile:MovieClip,fileName:String):SkeletonStruct
		{
			var numMc:int = swfFile.numChildren;
			var skeletonStruct:SkeletonStruct = new SkeletonStruct();
			skeletonStruct.name = fileName;
			skeletonStruct.mcList = new Vector.<McStruct>(numMc,true);
			for(var i:int = 0;i<numMc;++i)
			{
				skeletonStruct.mcList[i] = parseMc(swfFile.getChildAt(i) as MovieClip);
			}
			return skeletonStruct;
		}
		
		private static function parseMc(mc:MovieClip):McStruct
		{
			var mcLabels:Array = mc.currentLabels;
			var mcStruct:McStruct = new McStruct();
			mcStruct.name = mc.name;
			mcStruct.totalFrames = mc.totalFrames;
			mcStruct.packageList = new Vector.<BitmapDataPackage>(mcLabels.length,true);
			var frameLen:int = 0;
			for(var i:int =0;i<mcLabels.length;++i)
			{
				if(mcLabels[i+1])
					frameLen = mcLabels[i+1].frame - mcLabels[i].frame;
				else
					frameLen = mc.totalFrames - mcLabels[i].frame;
				mcStruct.packageList[i] = parseFrameToPackage(mcLabels[i],mc,frameLen);
			}
			return mcStruct;
		}
		
		private static function parseFrameToPackage(label:FrameLabel,mc:MovieClip,length:int):BitmapDataPackage
		{
			var packageStruct:BitmapDataPackage = new BitmapDataPackage();
			packageStruct.name = trim(label.name);
			packageStruct.bitmapFrames = new Vector.<BitmapFrame>(length,true);
			packageStruct.bitmapKeyFrames = new Vector.<BitmapKeyFrame>();
			for(var i:int =0;i<length;++i)
			{
				mc.gotoAndStop(label.frame+i);
				var rect:Rectangle = mc.getBounds(mc);
				var rx:int = rect.x >= 0 ?Math.ceil(rect.x):Math.floor(rect.x); 
				var ry:int = rect.y >= 0 ?Math.ceil(rect.y):Math.floor(rect.y); 
				rect = new Rectangle(rx,ry,Math.ceil(rect.width),Math.ceil(rect.height));
				if(rect.width == 0) rect.width = 1;
				if(rect.height == 0) rect.height = 1;
				var bmd:BitmapData = new BitmapData(rect.width,rect.height,true,0);
				var keyFrame:BitmapKeyFrame = new BitmapKeyFrame();
				var frame:BitmapFrame = new BitmapFrame();
				keyFrame.x = rect.x;
				keyFrame.y = rect.y;
				keyFrame.rect = rect;
				frame.index = mc.currentFrame-label.frame;
				bmd.draw(mc,new Matrix(1,0,0,1,-rect.x,-rect.y),null,null,null,true);
				keyFrame.bitmapData = bmd;
				packageStruct.bitmapKeyFrames.push(keyFrame);
				packageStruct.bitmapFrames[i] = frame;
			}
			return packageStruct;
		}
		
		private static function trim(str:String):String
		{
			while(str.charAt(0) == " ")
			{
				str = str.slice(1);
			}
			
			while(str.charAt(str.length-1) == " ")
			{
				str = str.slice(0,str.length-1);
			}	
			return str;
		}
	}
}
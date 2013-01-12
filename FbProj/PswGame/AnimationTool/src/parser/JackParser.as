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
			packageStruct.name = label.name;
			packageStruct.bitmapFrames = new Vector.<BitmapFrame>(length,true);
			packageStruct.bitmapKeyFrames = new Vector.<BitmapKeyFrame>();
			for(var i:int =0;i<length;++i)
			{
				var rect:Rectangle = mc.getBounds(mc);
				rect = new Rectangle(rect.x,rect.y,Math.floor(rect.width),Math.floor(rect.height));
				var bmd:BitmapData = new BitmapData(rect.width,rect.height,true,0);
				var keyFrame:BitmapKeyFrame = new BitmapKeyFrame();
				var frame:BitmapFrame = new BitmapFrame();
				keyFrame.x = rect.x;
				keyFrame.y = rect.y;
				keyFrame.rect = rect;
				mc.gotoAndStop(label.frame+i);
				frame.index = mc.currentFrame-label.frame;
				bmd.draw(mc,new Matrix(1,0,0,1,-rect.x,-rect.y),null,null,null,true);
				keyFrame.bitmapData = bmd;
				packageStruct.bitmapKeyFrames.push(keyFrame);
				packageStruct.bitmapFrames[i] = frame;
			}
			return packageStruct;
		}
	}
}
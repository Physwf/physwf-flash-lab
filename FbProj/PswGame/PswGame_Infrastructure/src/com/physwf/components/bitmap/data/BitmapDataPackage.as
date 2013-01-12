package com.physwf.components.bitmap.data {

	import com.physwf.components.bitmap.display.BitmapFrame;
	import com.physwf.components.bitmap.display.BitmapKeyFrame;
	import com.physwf.components.bitmap.display.BitmapPalyer;
	import com.physwf.components.bitmap.net.BitmapDataPackageLoader;
	import com.physwf.components.utils.AlgebraUtils;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sampler.getSize;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	/**
	 * 每一个位图数据包包含一组关键帧数据和一组普通帧数据，每一个普通帧都指向关键中包中的某一个位置（通过frame属性） 
	 * @author joe
	 * 
	 */
	public class BitmapDataPackage implements IExternalizable
	{

		public var endian:int = BitmapDataPackageLoader.PACKAGE_ENDIAN_JACK;
		public var name:String;
		
		public var bitmapKeyFrames:Vector.<BitmapKeyFrame>;
		public var bitmapFrames:Vector.<BitmapFrame>;

//		public var keyFrameRects:Array;
		public var frames:Array;
		
		public function BitmapDataPackage() 
		{
			
		}
		
		public function readExternal(input:IDataInput):void
		{
			var len:int ;
			var bmdBytes:ByteArray ;
			var rect:Rectangle;
			
			var keyLen:uint = input.readShort();
			for(var i:int=0;i<keyLen;++i)
			{
				bitmapKeyFrames[i].x = input.readShort();
				bitmapKeyFrames[i].y = input.readShort();
				rect = new Rectangle();
				rect.width = input.readShort();
				rect.height = input.readShort();
				len = input.readShort();
				bmdBytes = new ByteArray();
				input.readBytes(bmdBytes,0,len);
				bmdBytes.inflate();
				var bmd:BitmapData = new BitmapData(rect.width,rect.height,true,0x0FFFF0000);
				bmd.setPixels(rect,bmdBytes);
				trace(rect);
				bitmapKeyFrames[i].bitmapData = bmd;
			}
			var frameLen:uint = input.readShort();
			
			for(i = 0;i<frameLen;++i)
			{
				var frame:uint = input.readShort();
				bitmapFrames[i].keyFrame = bitmapKeyFrames[frame];
				trace(frame);
			}
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(endian);
			
			switch(endian)
			{
				case BitmapDataPackageLoader.PACKAGE_ENDIAN_JACK:
					writeJack(output);
					break;
				case BitmapDataPackageLoader.PACKAGE_ENDIAN_SPRITE:
					writeSprite(output);
					break;
				case BitmapDataPackageLoader.PACKAGE_ENDIAN_ELVES:
					writeElves(output);
					break;
			}
		}
		
		private function writeJack(output:IDataOutput):void
		{
//			trace(name)
			var nameData:ByteArray = new ByteArray();
			nameData.writeUTFBytes(name);
			output.writeShort(nameData.length);
			output.writeBytes(nameData);
			
			output.writeShort(bitmapKeyFrames.length);
			for(var i:int=0;i<bitmapKeyFrames.length;++i)
			{
				var bmd:BitmapData = bitmapKeyFrames[i].bitmapData;
				var rect:Rectangle = new Rectangle(bmd.rect.x,bmd.rect.y,bmd.rect.width,bmd.rect.height);
				output.writeShort(bitmapKeyFrames[i].x);
				output.writeShort(bitmapKeyFrames[i].y);
				var bytes:ByteArray = bmd.getPixels(rect);
				bytes.deflate();
				output.writeShort(rect.width);
				output.writeShort(rect.height);
				output.writeShort(bytes.length);
				output.writeBytes(bytes);
			}
			output.writeShort(bitmapFrames.length);
			for(i=0;i<bitmapFrames.length;++i)
			{
				output.writeShort(bitmapFrames[i].frame);
			}
		}
		
		private function writeSprite(output:IDataOutput):void
		{
			var len:int = bitmapKeyFrames.length;
			var nextPower:Number = AlgebraUtils.getNextPower(len);
			var canvas:Shape = new Shape();
			var rects:Vector.<Rectangle> = new Vector.<Rectangle>(len,true);//
			var point:Point = new Point(0,0);
			var curRect:Rectangle;
			for(var i:int=0;i<len;++i)
			{
				var row:int=i/nextPower;
				var column:int = i%nextPower;
				curRect = bitmapKeyFrames[i].bitmapData.rect;
				getMatrix(rects,curRect,point);
				canvas.graphics.beginBitmapFill(bitmapKeyFrames[i].bitmapData,getMatrix(rects,curRect,point),false);
				rects[i]=bitmapKeyFrames[i].bitmapData.rect;
			}
			var bmd:BitmapData = new BitmapData(canvas.width,canvas.height,true,0);
			bmd.draw(canvas);
			var bytes:ByteArray = bmd.getPixels(bmd.rect);
			bytes.deflate();
			output.writeShort(bytes.length);
			output.writeBytes(bytes);
		}
		
		private function getMatrix(rects:Vector.<Rectangle>,curRect:Rectangle,pos:Point):Matrix
		{
			for(var i:int=0;i<rects.length;++i)
			{
				if(rects[i].intersects(curRect))
					pos.y = rects[i].bottom;
				pos.x = pos.x+curRect.width;
			}
			return new Matrix(1,0,0,1,pos.x,pos.y);
		}
		
		private function writeElves(output:IDataOutput):void
		{
			
		}

	} // end class
} // end package
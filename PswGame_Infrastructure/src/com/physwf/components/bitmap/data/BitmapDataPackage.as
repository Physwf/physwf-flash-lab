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

	public class BitmapDataPackage implements IExternalizable
	{

		public var endian:int = BitmapDataPackageLoader.PACKAGE_ENDIAN_JACK;
		public var name:String;
		
		public var bitmapKeyFrames:Vector.<BitmapKeyFrame>;
		public var bitmapFrames:Vector.<BitmapFrame>;


		public function BitmapDataPackage() 
		{
			
		}
		
		public function readExternal(input:IDataInput):void
		{
			var len:int = input.readShort();
			name = input.readUTFBytes(len);
			
			var i:int=0;
			var bmdBytes:ByteArray ;
			while(input.bytesAvailable)
			{
				len = input.readShort();
				bmdBytes = new ByteArray();
				input.readBytes(bmdBytes,0,len);
				bitmapKeyFrames[i].bitmapData.setPixels(bitmapKeyFrames[i].rect,bmdBytes);
			}
		}
		
		public function writeExternal(output:IDataOutput):void
		{
			output.writeShort(endian);
			output.writeShort(getSize(name));
			output.writeUTF(name);
			
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
			for(var i:int=0;i<bitmapKeyFrames.length;++i)
			{
				var bmd:BitmapData = bitmapKeyFrames[i].bitmapData;
				var bytes:ByteArray = bmd.getPixels(bmd.rect);
				bytes.deflate();
				output.writeShort(bytes.length);
				output.writeBytes(bytes);
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
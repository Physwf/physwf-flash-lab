package writer
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import struct.ItemStruct;

	public class SpriteWriter
	{
		public function SpriteWriter()
		{
		}
		
		public function write(items:Vector.<ItemStruct>,canvasW:uint,canvasH:uint):void
		{
			var canvas:BitmapData = new BitmapData(canvasW,canvasH,true,0x00000000);
			
//			var id:uint = setInterval(function ():void
//			{
//				canvas.copyPixels(items[0].obj,items[0].obj.rect,items[0].position,null,null,true);
//				items.splice(0,1);
//				if(items.length==0)
//				{
//					clearInterval(id);
//				}
//			},2000);
			var spriteData:ByteArray = new ByteArray();
			spriteData.writeShort(items.length);
			
			for(var i:int=0;i<items.length;++i)
			{
				canvas.copyPixels(items[i].obj,items[i].obj.rect,items[i].position,null,null,true);
				spriteData.writeShort(items[i].id);
				spriteData.writeShort(items[i].position.x);
				spriteData.writeShort(items[i].position.y);
				spriteData.writeShort(items[i].obj.rect.width);
				spriteData.writeShort(items[i].obj.rect.height);
			}
			var bmdData:ByteArray = canvas.getPixels(canvas.rect);
			bmdData.deflate();
			spriteData.writeShort(canvas.width);
			spriteData.writeShort(canvas.height);
			spriteData.writeUnsignedInt(bmdData.length);
			spriteData.writeBytes(bmdData);
			var fs:FileStream = new FileStream();
			var file:File = new File("C:/Users/joe/Desktop/ui.swf");
			fs.open(file,FileMode.WRITE);
			fs.writeBytes(spriteData);
			
			var windowOptions:NativeWindowInitOptions = new NativeWindowInitOptions();
			windowOptions.maximizable = false;
			windowOptions.systemChrome = NativeWindowSystemChrome.ALTERNATE;
			windowOptions.type = NativeWindowType.NORMAL;
			var window:NativeWindow = new NativeWindow(windowOptions);
			window.width = canvasW;
			window.height = canvasH;
			window.stage.align = StageAlign.TOP_LEFT;
			window.stage.scaleMode = StageScaleMode.NO_SCALE;
			window.stage.addChild(new Bitmap(canvas));
			window.activate();
			window.x = 400;
		}
	}
}
package psw2d.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import psw2d.Alcedo;
	import psw2d.core.Context2D;
	import psw2d.display.animation.IAnimation;
	import psw2d.render.RenderMaster;
	import psw2d.texture.BitmapTexture;
	import psw2d.texture.Texture;
	
	public class SimpleImagePlayer extends Image implements IAnimation
	{
		private var totalFrames:int;
		private var _frames:Vector.<Number>;
		private var _curentFrame:int;
		private var _frameWidth:Number;
		private var _frameHeight:Number;
		
		public function SimpleImagePlayer(texture:Texture,w:Number,h:Number,numFrames:int)
		{
			super(texture);
			width = w; height = h;
			totalFrames = numFrames;
			
			setCoords(0,0,0); 
			setCoords(1,width,0);
			setCoords(2,width,height);
			setCoords(3,0,height);
			
			var numX:int =  texture.width /w ;
			var numY:int =  texture.height / h ;
			var unitX:Number = 1/numX;
			var unitY:Number = 1/numY;
			var curFrame:int;
			_frames = new <Number>[];
			for(var i:int=0;i<numY;i++)
			{
				for(var j:int=0;j<numX;j++)
				{
					curFrame = i * numY +j;
					_frames.push(
						unitX * j,unitY * i,
						unitX * (j+1),unitY * i,
						unitX * (j+1),unitY * (i+1),
						unitX * j,unitY * (i+1)
					);
				}
			}
			gotoFrame(0);
		}
		
		public function addvanceTime(time:Number):void
		{
			gotoFrame(_curentFrame);
			
			if(_curentFrame < totalFrames) 
			{
				_curentFrame++;
			}
			else
			{
				_curentFrame=0;
			}
			
		}

		private function gotoFrame(frameNum:int):void
		{
			var offset:int = frameNum * 8;
			for(var i:int=0;i<4;++i)
			{
				_vertexData.setTexCoords(i,_frames[offset+2*i],_frames[offset+2*i+1]);
			}
		}

	}
}
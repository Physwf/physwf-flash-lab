package
{
	import com.physwf.components.effects.EffectFrame;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Scissor
	{
		public static var regX:uint;
		public static var regY:uint;
		
		public function Scissor()
		{
		}
		
		public static function extract(raw:BitmapData):EffectFrame
		{
			var minX:uint = uint.MAX_VALUE;
			var minY:uint = uint.MAX_VALUE;
			var maxX:uint = uint.MIN_VALUE;
			var maxY:uint = uint.MIN_VALUE;
			
			for(var x:uint=0;x<raw.width;++x)
			{
				for(var y:uint=0;y<raw.height;++y)
				{
					var pixel:uint = raw.getPixel32(x,y);
//					pixel &= 0xFF000000;
//					pixel >>=24;
					if(pixel>0)
					{
						if(x<minX)
						{
							minX = x;
						}
						if(y<minY)
						{
							minY = y;
						}
						if(x>maxX)
						{
							maxX = x;
						}
						if(y>maxY)
						{
							maxY = y;
						}
					} 
				}
			}
			var frame:EffectFrame = new EffectFrame();
			frame.x = minX - regX;
			frame.y = minY - regY;
			var bmd:BitmapData = new BitmapData(maxX - minX,maxY - minY,true,0);
			bmd.copyPixels(raw,new Rectangle(minX,minY,bmd.width,bmd.height),new Point());
			frame.frameData = bmd;
			return frame;
		}
	}
}
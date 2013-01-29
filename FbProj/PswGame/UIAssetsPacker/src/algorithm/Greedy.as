package algorithm
{
	import algorithm.objects.Angle;
	import algorithm.objects.Configuration;
	import algorithm.objects.Line;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import struct.ItemStruct;

	public class Greedy extends EventDispatcher
	{
		private var configuration:Configuration;
		
		public function Greedy(cfg:Configuration)
		{
			configuration = cfg;
		}
		
		public function pack(images:Vector.<BitmapData>,items:Vector.<ItemStruct>):void
		{
			while(images.length > 0)
			{
				configuration.sortAgl();
				var curAngle:Angle = configuration.shiftAgl();
				if(curAngle == null) 
				{
					break;
				}
				
				var boarder:Line = configuration.getNearestBoarder(curAngle.pos);
				var minDist:Number = Number.MAX_VALUE;
				
				if(boarder)
				{
					var tempImage:BitmapData = null;
					for(var i:int=0;i<images.length;++i)
					{
						var r:Rectangle = new Rectangle();
						r.x= curAngle.pos.x;
						r.y= curAngle.pos.y;
						r.width = images[i].width;
						r.height = images[i].height;
						
						
						if(r.right<=boarder.pos)
						{
							var dist:Number = boarder.pos - r.right;
							if(minDist>dist && dist>0)
							{
								tempImage = images[i];
								minDist = dist;
							}
						}
					}
					
					if(tempImage)
					{
						var item:ItemStruct = new ItemStruct(curAngle.pos,tempImage);
						configuration.addHoldedAgl(curAngle);
						var txt:TextField = new TextField();
						txt.text = ""+item.id;
						var b:BitmapData = new BitmapData(txt.width,txt.height,true,0);
						b.draw(txt);
						tempImage.copyPixels(b,b.rect,new Point(),null,null,true);
						items.push(item);
						
						configuration.addAgl(new Angle(new Point(item.position.x+item.obj.width,item.position.y),item.obj.height));
						var a:Point = new Point(item.position.x,item.position.y+item.obj.height);
						configuration.addAgl(new Angle(new Point(item.position.x,item.position.y+item.obj.height),item.obj.height));
						configuration.addBoarder(new Line(item.position.y,item.position.y+item.obj.height,item.position.x,null));
						var index:int = images.indexOf(tempImage);
						images.splice(index,1);
					}
				}
			}
			
			dispatchEvent(new Event("done"));
			return;
		}
	}
}
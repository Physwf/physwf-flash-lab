package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display3D.Context3DTextureFormat;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import psw2d.Alcedo;
	import psw2d.display.Image;
	import psw2d.display.Quad;
	import psw2d.render.ImageRender;
	import psw2d.render.QuadRender;
	import psw2d.texture.BitmapTexture;
	import psw2d.texture.Texture;
	
	public class SparrowTest extends flash.display.Sprite
	{
		private var _sparrow:Alcedo;
		[Embed(source="../texture/walksequence_spritesheet2.png")]
		private var WalkMan:Class;
		
		public function SparrowTest()
		{
			stage?onAddToStage(null):
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			_sparrow = new Alcedo(Game,stage,stage.stage3Ds[0]);
			_sparrow.addEventListener("contextCreated",onContextCreated);
			_sparrow.start();
			
			var walkMan:Bitmap = new WalkMan() as Bitmap;
			var w:int = 240;
			var h:int = 296;
			var texBd:BitmapData = new BitmapData(2048,256,true,0x00000000);
			var c:uint = 0xFF000000;
			var sX:Number;
			var sY:Number;
			var sW:Number = 240;
			var sH:Number = 296;
			var tX:Number;
			var tY:Number;
			var scale:Number = 0.4;
			for(var i:int=0;i<5;i++)
			{
				for(var j:int=0;j<6;++j)
				{
					sX = j*240;
					sY = i*296;
					tX = (i*6+j) * 128;
					tY = 0;
					if((i*6+j)>15) tX = (i*6+j-16) * 128;
					if((i*6+j)>15) tY = 128;
					var m:Matrix = new Matrix(scale,0,0,scale,tX - sX *scale ,tY - sY * scale);
					var r:Rectangle = new Rectangle(tX,tY,sW*scale,sH*scale);
					texBd.draw(walkMan.bitmapData,m,null,null,r);
				}
			}
//			var b:Bitmap = addChild(new Bitmap(texBd)) as Bitmap;
//			b.scaleX = b.scaleY = 1;
		}
		private var qRender:QuadRender;
		private var imageRender:ImageRender;

		private var imageRender2:ImageRender;
		

		
		public function onContextCreated(e:Event):void
		{
			Alcedo.context.setOrthographicProjection(stage.stageWidth,stage.stageHeight);
		}
		
	}
}
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;

import psw2d.Alcedo;
import psw2d.display.DisplayObject;
import psw2d.display.Image;
import psw2d.display.Quad;
import psw2d.display.SimpleImagePlayer;
import psw2d.display.Sprite;
import psw2d.texture.BitmapTexture;
import psw2d.texture.Texture;

class Game extends Sprite
{
	private var q:Quad;
	private var q2:Quad;
	private var image:Image;
	private var image2:Image;
	
	[Embed(source="../texture/flower.png")]
	private var Flower2:Class;
	[Embed(source="../texture/bird.jpg")]
	private var Bird:Class;
	[Embed(source="../texture/walksequence_spritesheet2.png")]
	private var WalkMan:Class;
	
	private var timer:Timer = new Timer(30);
	private var sp:MovieClip = new MovieClip();
	public function Game()
	{
		q = new Quad(100,100,0x7FFF0000);
		q.x = 100;
		q.y = 100;
		q2 = new Quad(100,100,0x7F00FF00);
		q2.x = 150;
		q2.y = 100;
		
//		addChild(q);
//		addChild(q2);
		
		var flower:Bitmap = new Flower2() as Bitmap;
		var tex:Texture = Alcedo.context.createBitmapTexture(flower,false) as Texture;
		image = new Image(tex);
		image.x = 200;
		image.y = 200;
		
		var bird:Bitmap = new Bird() as Bitmap;
		var tex2:Texture = Alcedo.context.createBitmapTexture(bird,false) as Texture;
		image2 = new Image(tex2);
		image2.x = 400;
		
//		addChild(image);
//		addChild(image2);
		
		var walkMan:Bitmap = new WalkMan() as Bitmap;
		trace(walkMan.width/6,walkMan.height/5);
		var texBd:BitmapData = new BitmapData(2048,256,true,0x00000);
		var sX:Number;
		var sY:Number;
		var sW:Number = 240;
		var sH:Number = 296;
		var tX:Number;
		var tY:Number;
		var scale:Number = 0.4;
		for(var i:int=0;i<5;i++)
		{
			for(var j:int=0;j<6;++j)
			{
				sX = j*240;
				sY = i*296;
				tX = (i*6+j) * 128;
				tY = 0;
				if((i*6+j)>15) tX = (i*6+j-16) * 128;
				if((i*6+j)>15) tY = 128;
				var m:Matrix = new Matrix(scale,0,0,scale,tX - sX *scale ,tY - sY * scale);
				var r:Rectangle = new Rectangle(tX,tY,sW*scale,sH*scale);
				texBd.draw(walkMan.bitmapData,m,null,null,r);
			}
		}

		var text:BitmapTexture = Alcedo.context.createBitmapTexture(texBd,false);
		

		
		for(i=0;i<1;++i)
		{
			var imageAnim:SimpleImagePlayer = new SimpleImagePlayer(text,128,128,29);
			var im:DisplayObject = addChild(imageAnim);
			
			im.x = 500*Math.random();
			im.y = 400*Math.random();
		}
		
		
		timer.addEventListener(TimerEvent.TIMER,onTimer);
//		timer.start();
		sp.addEventListener(Event.ENTER_FRAME,onTimer);
	}
	
	private function onTimer(e:Event):void
	{

	}
		
}